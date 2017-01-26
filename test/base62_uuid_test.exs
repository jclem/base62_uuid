defmodule Base62UUIDTest do
  use ExUnit.Case, async: true

  @short_uuid "063cd93e-dd59-43b6-928b-2d00a49087fc"

  test ".generate generates a UUID" do
    assert Base62UUID.generate |> String.length == 22
  end

  test ".encode encodes a UUID" do
    assert Base62UUID.encode(UUID.uuid4) |> String.length == 22
  end

  test ".encode pads a short UUID" do
    assert Base62UUID.encode(@short_uuid) |> String.length == 22
  end

  test ".decode decodes a UUID" do
    uuid = UUID.uuid4
    assert uuid |> Base62UUID.encode |> Base62UUID.decode == {:ok, uuid}
  end

  test ".decode decodes a short UUID" do
    base62 = Base62UUID.encode(@short_uuid)
    assert match? {:ok, @short_uuid}, Base62UUID.decode(base62)
  end
end
