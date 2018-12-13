# Base62UUID [![Build Status](https://travis-ci.com/jclem/base62_uuid.svg?branch=master)](https://travis-ci.com/jclem/base62_uuid)

A library for generating 22-byte-length, base-62-encoded v4 UUIDs.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
as:

  1. Add `base62_uuid` to your list of dependencies in `mix.exs`:

        def deps do
          [{:base62_uuid, "~> 0.1.0"}]
        end

  2. Ensure `base62_uuid` is started before your application:

        def application do
          [applications: [:base62_uuid]]
        end

## Usage

```elixir
Base62UUID.generate
```
