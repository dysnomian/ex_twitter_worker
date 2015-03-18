defmodule TwitterAdapter.TwitterAPI do
  ExTwitter.configure

  @doc ~S"""
  Returns an integer value for the friends count of a given user.

  ## Examples

      iex> TwitterAdapter.friends_for("derekharms")
      [168]

  """
  def friends_for(username) do
    ExTwitter.user_lookup(username) |>
    Enum.map(fn(user) -> user.friends_count end)
  end
end
