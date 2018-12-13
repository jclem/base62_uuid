defmodule Base62UUID do
  @moduledoc """
  A base 62-encoded v4 UUID.
  """

  @length 22
  @uuid_length 32

  @doc """
  Generate a 22-byte base-62-encoded v4 UUID.
  """
  @spec generate :: String.t()
  def generate do
    encode!(UUID.uuid4())
  end

  @doc """
  Encode a v4 UUID to a 22-byte encoded UUID.

  Returns an error message if the UUID was invalid.

  # Example

      iex> Base62UUID.encode("063cd93e-dd59-43b6-928b-2d00a49087fc")
      {:ok, "0BllEZppLhVt2a9PljPUJ2"}
  """
  @spec encode(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(uuid) do
    {:ok, encode!(uuid)}
  rescue
    e in ArgumentError -> {:error, e.message}
  end

  @doc """
  Encode a v4 UUID to a 22-byte encoded UUID, and raise on an error.

  # Example

      iex> Base62UUID.encode!("063cd93e-dd59-43b6-928b-2d00a49087fc")
      "0BllEZppLhVt2a9PljPUJ2"
  """
  @spec encode!(String.t()) :: String.t()
  def encode!(uuid) do
    uuid
    |> String.replace("-", "")
    |> String.to_integer(16)
    |> Base62.encode()
    |> ensure_length(@length)
  end

  @doc """
  Decode a an encoded UUID.

  Returns an error tuple if the UUID is invalid.

  # Example

      iex> Base62UUID.decode("0BllEZppLhVt2a9PljPUJ2")
      {:ok, "063cd93e-dd59-43b6-928b-2d00a49087fc"}
  """
  @spec decode(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(uuid) do
    with {:ok, int} <- Base62.decode(uuid),
         raw_uuid = Integer.to_string(int, 16),
         raw_uuid = ensure_length(raw_uuid, @uuid_length),
         {:ok, uuid} <- make_uuid(raw_uuid) do
      {:ok, uuid}
    else
      _ -> {:error, "Invalid base-62 UUID"}
    end
  end

  @doc """
  Decode a an encoded UUID.

  # Example

      iex> Base62UUID.decode!("0BllEZppLhVt2a9PljPUJ2")
      "063cd93e-dd59-43b6-928b-2d00a49087fc"
  """
  @spec decode!(String.t()) :: String.t()
  def decode!(uuid) do
    case decode(uuid) do
      {:ok, uuid} -> uuid
      {:error, error} -> raise error
    end
  end

  @spec ensure_length(String.t(), pos_integer) :: String.t()
  defp ensure_length(encoded, length) when byte_size(encoded) == length,
    do: encoded

  defp ensure_length(encoded, length) do
    difference = length - String.length(encoded)
    String.duplicate("0", difference) <> encoded
  end

  @spec make_uuid(String.t()) :: {:ok, String.t()} | :error
  defp make_uuid(raw_uuid) do
    with <<gp_1::binary-size(8), gp_2::binary-size(4), gp_3::binary-size(4), gp_4::binary-size(4),
           gp_5::binary-size(12)>> <- String.downcase(raw_uuid) do
      {:ok, [gp_1, gp_2, gp_3, gp_4, gp_5] |> Enum.join("-")}
    else
      _ -> :error
    end
  end
end
