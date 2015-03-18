defmodule TwitterAdapter.PubSub do
  @doc ~S"""
  Adds a message with the content of `message` on Redis on the namespace
  "twitter_#{`channel`}".

  ## Examples

      iex> TwitterAdapter.post("test", "Hello world.")
      {:ok, {"twitter_test", "Hello world."}}

  """
  def post(channel, message) do
    client_sub = Exredis.Sub.start
    client = Exredis.start
    pid = Kernel.self

    client |> Exredis.Api.publish "twitter_#{channel}", message
  end

  def requests(namespace) do
    client_sub = Exredis.Sub.start
    client = Exredis.start
    pid = Kernel.self

    client_sub |>
    Exredis.Sub.psubscribe "twitter_#{namespace}", fn(msg) ->
      send(pid, msg)
    end

    receive do
      msg ->
        IO.inspect msg
    end
  end
end
