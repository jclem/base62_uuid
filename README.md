# Base62UUID [![Build Status](https://travis-ci.com/jclem/base62_uuid.svg?branch=master)](https://travis-ci.com/jclem/base62_uuid) [![Coverage Status](https://coveralls.io/repos/github/jclem/base62_uuid/badge.svg?branch=master)](https://coveralls.io/github/jclem/base62_uuid?branch=master)

A library for generating 22-byte-length, Base62-encoded v4 UUIDs.

UUIDs are great for use as primary keys in relational databases, but they don't look great in URLs. This library makes it easy to generate, encode, and decode Base62 v4 UUIDs that have a guaranteed length of 22 bytes. That way, rather than URLs that look like:

```
https://example.com/widgets/7af42354-0835-475f-adb5-15fc893526e1
```

You can have a shorter and friendlier looking URL like:

```
https://example.com/widgets/3k0dNymf72EzlHEkZLwjhZ
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
as:

  1. Add `base62_uuid` to your list of dependencies in `mix.exs`:
    
     ```elixir
     def deps do
       [{:base62_uuid, "~> 2.0.0"}]
     end
     ```

  2. Ensure `base62_uuid` is started before your application:

     ```elixir
     def application do
       [applications: [:base62_uuid]]
     end
     ```

## Usage

### Generate a Base62-encoded UUID

```elixir
iex> Base62UUID.generate()
"5rljkyCY7vXDv2bPAnCQdL"
```

### Encode a UUID to Base62

```elixir
iex> Base62UUID.encode("7af42354-0835-475f-adb5-15fc893526e1")
{:ok, "3k0dNymf72EzlHEkZLwjhZ"}
```

### Decode a Base62-encoded UUID

```elixir
iex> Base62UUID.decode("3k0dNymf72EzlHEkZLwjhZ")
{:ok, "7af42354-0835-475f-adb5-15fc893526e1"}
```
