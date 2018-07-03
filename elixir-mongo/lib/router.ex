defmodule Testwo.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/hello" do
    hello(conn)
  end

  get "/bench/:id" do
    body = Bench.start_it(id)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, body)
  end

  get "/hello/:name" do
    hello(conn, name)
  end

  match _ do
    goodbye(conn)
  end

  defp hello(conn, name \\ "World") do
    body = "Hello, #{String.capitalize(name)}!"

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, body)
  end

  defp goodbye(conn) do
    body = "Goodbye!"

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, body)
  end
end
