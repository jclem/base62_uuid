defmodule Base62UUIDTest do
  use ExUnit.Case, async: true

  doctest Base62UUID

  @short_uuid "063cd93e-dd59-43b6-928b-2d00a49087fc"

  test ".generate generates a UUID" do
    assert Base62UUID.generate() |> String.length() == 22
  end

  test ".encode encodes a UUID" do
    {:ok, encoded} = Base62UUID.encode(UUID.uuid4())
    assert String.length(encoded) == 22
  end

  test ".encode pads a short UUID" do
    {:ok, encoded} = Base62UUID.encode(@short_uuid)
    assert String.length(encoded) == 22
  end

  test ".encode handles an invalid UUID" do
    assert Base62UUID.encode("not-a-uuid") ==
             {:error,
              "errors were found at the given arguments:\n\n  * 1st argument: not a textual representation of an integer\n"}
  end

  test ".encode! encodes a UUID" do
    assert Base62UUID.encode!(UUID.uuid4()) |> String.length() == 22
  end

  test ".encode! raises an error" do
    assert_raise(
      ArgumentError,
      "errors were found at the given arguments:\n\n  * 1st argument: not a textual representation of an integer\n",
      fn -> Base62UUID.encode!("not a UUID") end
    )
  end

  test ".decode decodes a UUID" do
    uuid = UUID.uuid4()
    assert uuid |> Base62UUID.encode!() |> Base62UUID.decode() == {:ok, uuid}
  end

  test ".decode decodes a short UUID" do
    base62 = Base62UUID.encode!(@short_uuid)
    assert match?({:ok, @short_uuid}, Base62UUID.decode(base62))
  end

  test ".decode returns an error" do
    assert {:error, "Invalid base-62 UUID"} == Base62UUID.decode("!")
  end

  test ".decode! decodes a UUID" do
    uuid = UUID.uuid4()
    assert uuid |> Base62UUID.encode!() |> Base62UUID.decode!() == uuid
  end

  test ".decode! raises an error" do
    assert_raise RuntimeError, "Invalid base-62 UUID", fn -> Base62UUID.decode!("!") end
  end
end
