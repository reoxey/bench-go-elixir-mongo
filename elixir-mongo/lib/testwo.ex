defmodule Testwo do
  use Application
  @moduledoc """
  Documentation for Testwo.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Testwo.hello
      :world

  """
  
  def start(_type, _args) do
    port = Application.get_env(:server, :port)

    Plug.Adapters.Cowboy2.http(Testwo.Router, [], [port: port])

  end

end
