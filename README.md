# TD Challange

Full Challange description can be found in [CHALLENGE.md](CHALLENGE.md)

## Installation

Checkout the source and run:

```
$ bundle install
```

## Basic Usage

#### Wolframalpha

```bash
$ bin/wolfram -l {YAML_PATH} -a {APPID}

["beanshell", "clojure", "coffeescript", "d", "elixir", "falcon", "fantom", "ferite", "frink", "groovy", "ioke", "judoscript", "mantra", "nu", "perl-6", "urbi", "powershell", "ambienttalk", "cadence-skill", "clojure", "common-lisp", "dylan", "ecmascript", "eulisp", "ferite", "goo", "haskell", "javascript", "joy", "k", "kernel"
```

Command flag              | Description
--------------------------|------------------------------------------------------------
`-h/--help`               | Display usage help
`-l/--list`               | Language list (yml)
`-a,/--app-id APPID`      | Set Wolfram appid

#### Stackexchange
```bash
$ bin/stackexchange -l {YAML_PATH}
{"ruby"=>119404, "haskell"=>19370, "scheme"=>3863}
```

Command flag              | Description
--------------------------|------------------------------------------------------------
`-h/--help`               | Display usage help
`-l/--list`               | Language list (yml)

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.
