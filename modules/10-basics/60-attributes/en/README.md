
Sometimes, in a module, you need to put some values into constants, for this use attributes starting with `@` sign.

```elixir
defmodule MyModule do
  @magic_number 8

  def do_magic(num) do
    num * @magic_number
  end
end

MyModule.do_magic(10) # 80
```

Module attributes are not available from outside the module.

```elixir
defmodule MyModule do
  @magic_number 8
end

MyModule.@magic_number # raises error
```

Attributes can be declared several times and redefined, but it should be noted that the compiler inlines the last value of the declared attribute, for example:

```elixir
defmodule MyModule do
  @magic_number 8

  def cast_magic() do
    @magic_number
  end

  @magic_number 0

  def do_magic() do
    @magic_number
  end
end

MyModule.cast_magic() # 8

MyModule.do_magic() # 0

# after compilation module attributes inlines like this 
defmodule MyModule do
  @magic_number 8

  def cast_magic() do
    8
  end

  @magic_number 0

  def do_magic() do
    0
  end
end
```

Within modules, there are also special attributes that are used by Elixir to generate documentation, such as the `@moduledoc` attribute that describes general information about the module or the `@doc` attribute that documents a declared function:

```elixir
defmodule MyModule do
  @moduledoc "My attributes exercise module."

  @magic_number 8

  @doc "Do some magic calculations."
  def do_magic(num) do
    num * @magic_number
  end
end
```

Then, these attributes are used in documentation generation.

You can also make a module attribute accumulate redefined values, with a special attribute declaration, for example:

 ```elixir
defmodule MyModule do
  Module.register_attribute __MODULE__, :magic_values, accumulate: true

  @magic_values 8
  @magic_values :some
  @magic_values "hello"

  def do_magic() do
    @magic_values
  end
end

MyModule.do_magic # [8, :some, "hello"]
```
