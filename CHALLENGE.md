# Coding Challenge
 
## General note
 
* Write reasonable tests.
* Make a good readme on how to execute this app on the command line.
 
## Task 1
 
Query the Wolfram Alpha API and parse the output.
 
The Wolfram Alpha API allows you to pass a list of programming languages.
The result contains a table with a new set of languages which were influenced by the requested programming languages.
 
### Input
 
A yaml file with the sample contents:
 
    ---
    - langs: [ruby, scheme, haskell]
 
### Output
 
A list with languages which were all influenced by the input languages:
 
    ['Perl','Lisp', 'Dylan', 'Elixir', ... ]
 
## Task 2
 
Query the Stackexchange API and parse the output.
 
Handle the input list (programming languages as strings) as stackoverflow tags and retrieve the "stackoverflow-tag-usage-count" from the API.
 
### Input
 
A yaml file with the sample contents:
 
    ---
    - langs: [ruby, scheme, haskell]
 
### Output
 
A hash holding the programming languages as keys and the according "stackoverflow-tag-usage-count" as values, printed in order by value:
 
    {
        'ruby' => 10000,
        'haskell' => 5000,
        ...
    }
