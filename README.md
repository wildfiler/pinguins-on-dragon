# Penguins on Dragon

Penguins on Dragon(PoD) is a library for creating games in [Dragon Ruby GTK](https://dragonruby.org/toolkit/game).

Partially inspired by [Zif](https://github.com/danhealy/dragonruby-zif) library.


## Installation

1. Create a `lib` directory inside the base directory of your DR game.
2. Copy `lib/engine` directory to created `lib`.
3. Add `require 'lib/engine/engine.rb` to the top of your `app/main.rb` file.

## Usage

To start using PoD, you need to add your game class and make changes to `main.rb`.

Simple game class can look like this:

`app/my_game.rb`:

```ruby
class MyGame < Engine::Game
  def tick(args)
    outputs.labels << [600, 300.from_top, "Welcome to Penguins on Dragon!"]
  end
end
```

`app/main.rb`:

```ruby
require 'lib/engine/engine.rb'
require 'app/my_game.rb'

def tick(args)
  Engine::Game.tick(MyGame, args)
end
```

If you want to add docs to DRGTK console add `require 'lib/engine/engine_docs.rb` to `main.rb` file.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
