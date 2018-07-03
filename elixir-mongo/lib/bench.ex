defmodule Bench do
  use Application
  import Supervisor.Spec

  def start_it(profile) do

    {pid, ref} = spawn_monitor(Bench, :run, [profile])

    receive do
      {:DOWN, ref, :process, from_pid, reason} ->
        if reason != :normal do
          IO.inspect reason
        end

        "."
    end
  end

  def run(profile) do
    dbnm = Application.get_env(:mongo, :dbnm)
    #    {:ok, conn} = Mongo.start_link(
    #      url: "mongodb://localhost:27017/" <> dbnm,
    #      pool: DBConnection.Poolboy
    #    )

    children = [
      worker(Mongo, [[name: :mongo, database: dbnm, pool: DBConnection.Poolboy]])
    ]

    opts = [strategy: :one_for_one, name: Testwo.Supervisor]
    Supervisor.start_link(children, opts)

    today = DateTime.utc_now
    date = Enum.join [today.year, today.month, today.day, today.hour, today.minute, today.second], ""

    ins = %{
      :date => date,
	  :name => "Hemraj",
	  :username => "reoxey",
	  :email => "reoxey@example.com",
	  :place => "Goa",
	  :country => "India",
	  :phone => "+91 (000) 000 0000",
	  :profile => profile
    }

    id = mongoI(:mongo, ins)
#    IO.inspect id

  end

  defp mongoF(conn, filter) do
    cursor = Mongo.find(conn, "bench_elixir", filter)

    cursor
    |> Enum.to_list()
    #    |> IO.inspect
  end

  defp mongoI(:mongo, doc) do
    cursor = Mongo.insert_one(:mongo, "bench_elixir", doc, pool: DBConnection.Poolboy)

    {:ok, obj} = cursor

    obj.inserted_id
    |> to_string
  end

  defimpl String.Chars, for: BSON.ObjectId do
    def to_string(object_id), do: Base.encode16(object_id.value, case: :lower)
  end

end
