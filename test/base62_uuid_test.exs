defmodule Base62UUIDTest do
  use ExUnit.Case, async: true

  test ".generate generates a UUID" do
    assert Base62UUID.generate |> String.length == 22
  end
end
