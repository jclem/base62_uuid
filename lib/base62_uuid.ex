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

  @doc """
  Decodea an encoded UUID.
  """
  @spec decode(String.t) :: {:ok, String.t} | {:error, String.t}
  def decode("0" <> uuid), do: decode(uuid)

  def decode(uuid) do
    with {:ok, int} <- Base62.decode(uuid),
         raw_uuid <- Integer.to_string(int, 16),
         {:ok, uuid} <- make_uuid(raw_uuid) do
       {:ok, uuid}
    else
      _ -> {:error, "Invalid base-62 UUID"}
    end
  end

  @spec ensure_length(String.t) :: String.t
  defp ensure_length(encoded) when byte_size(encoded) == @length, do: encoded
  defp ensure_length(encoded) do
    difference = @length - String.length(encoded)
    String.duplicate("0", difference) <> encoded
  end

  @spec make_uuid(String.t) :: String.t
  defp make_uuid(raw_uuid) do
    with <<gp_1::binary-size(8),
           gp_2::binary-size(4),
           gp_3::binary-size(4),
           gp_4::binary-size(4),
           gp_5::binary-size(12)>> <- String.downcase(raw_uuid) do
      {:ok, [gp_1, gp_2, gp_3, gp_4, gp_5] |> Enum.join("-")}
    else
      _ -> :error
    end
  end
end
