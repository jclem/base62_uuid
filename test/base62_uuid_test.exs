defmodule Base62UUIDTest do
  use ExUnit.Case, async: true

  test ".generate generates a UUID" do
    assert Base62UUID.generate |> String.length == 22
  end

  test ".encode encodes a UUID" do
    assert Base62UUID.encode(UUID.uuid4) |> String.length == 22
  end

  test ".decode decodes a UUID" do
    uuid = UUID.uuid4
    assert uuid |> Base62UUID.encode |> Base62UUID.decode == uuid
  end
end
