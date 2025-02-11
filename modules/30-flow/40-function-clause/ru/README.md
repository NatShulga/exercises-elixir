
В Эликсир одна функция может иметь несколько тел -- несколько разных блоков кода. В зависимости от входящих аргументов выполняется только один из этих блоков.

По-английски термин "тело функции" пишется *clause* и произносится `[klôz]`. Поскольку это короче, то все Эликсир разработчики предпочитают говорить "клоз" вместо "тело функции".

```elixir
def handle({:dog, name}, :add) do
  IO.puts("add dog #{name}")
end

def handle({:dog, name}, :remove) do
  IO.puts("remove dog #{name}")
end

def handle({:cat, name}, :add) do
  IO.puts("add cat #{name}")
end

def handle({:cat, name}, :remove) do
  IO.puts("remove cat #{name}")
end
```

Здесь функция `handle/2` имеет 4 тела. Шаблоны описываются прямо в аргументах функции, отдельно для каждого тела. Принцип такой же, как и с конструкцией *case* -- шаблоны проверяются по очереди на совпадение с входящими аргументами функции. Первый совпавший шаблон вызывает соответствующий блок кода и останавливает дальнейший перебор. Если ни один шаблон не совпал, то генерируется исключение.

Как и в случае с *case*, здесь тоже важна очередность шаблонов. Типичная ошибка -- расположить более общий шаблон выше, чем более специфичный шаблон:

```elixir
def handle(animal, action) do
  IO.puts("do something")
end

def handle({:dog, name}, :add) do
  IO.puts("add dog #{name}")
end
```

Во многих таких случаях компилятор выдаст предупреждение:

```elixir
warning: this clause for handle/2 cannot match because a previous clause at line 27 always matches
```

Но бывает, что компилятор не замечает проблему.

Как и с *case*, с телами функций могут использоваться охранные выражения:

```elixir
def handle({:dog, name, age}) when age > 10 do
  IO.puts("#{name} is a dog older than 10")
end

def handle({:dog, name, _age}) do
  IO.puts("#{name} is a 10 years old or younger dog")
end

def handle({:cat, name, age}) when age > 10 do
  IO.puts("#{name} is a cat older than 10")
end

def handle({:cat, name, _age}) do
  IO.puts("#{name} is a 10 years old or younger cat")
end
```

Конструкция *case* и тела функций полностью эквивалентны друг другу. Выбор того или иного варианта является личным предпочтением разработчика.
