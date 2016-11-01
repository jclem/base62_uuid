defmodule Base62UUID do
  @moduledoc """
  A base 62-encoded v4 UUID.
  """

  @length 22

  @doc """
  Generate a 22-byte base-62-encoded v4 UUID.
  """
  @spec generate :: String.t
  def generate do
    UUID.uuid4 |> encode
  end

  @doc """
  Encode a v4 UUID to a 22-byte encoded UUID.
  """
  @spec encode(String.t) :: String.t
  def encode(uuid) do
    uuid
    |> String.replace("-", "")
    |> String.to_integer(16)
    |> Base62.encode
    |> ensure_length
  end

  @spec ensure_length(String.t) :: String.t
  defp ensure_length(encoded) when byte_size(encoded) == @length, do: encoded
  defp ensure_length(encoded) do
    difference = @length - String.length(encoded)
    String.duplicate("0", difference) <> encoded
  end
end
