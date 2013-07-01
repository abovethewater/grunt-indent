[![build status](https://secure.travis-ci.org/abovethewater/indents.png)](http://travis-ci.org/abovethewater/indents)

# indents

**Easily convert between project indentation levels**

Files must pass initial linting

The indentation will then be changed to the specified level, and the file will be re-linted with the new config.

Existing linting config will need to be updated to specify the new indentation level

## Warning

The default process is destructive, and will overwrite existing files

## TODO

**TODO export new config**

**TODO protect against single space**

**TODO consider making non destructive by default**

**TODO spaces to spaces**

## Installation

    npm install -g indents

## Local installation

    cake install

## Run

    bin/indents

## Usage

  Usage: indents [options] files

  Options:

    -h, --help                   output usage information
    -V, --version                output the version number
    -l, --linter [linter]        use linter config
    -t, --tabstospaces [spaces]  convert indentation from tabs to spaces
    -s, --spacestotabs [spaces]  convert indentation from spaces to tabs
    -o, --output [path]          output to a given folder

## linter

Change default linting options in linter/coffeelint.json

Currently only supports CoffeeScript.

## tabstospace n

Converts tabs to n number of spaces

## spacestotabs n

Converts n space indent to tabs

## output

Specify an alternative output directory, otherwise original files will be overwritten

## Licence

[MIT](http://abovethewater.mit-license.org/)

## Credits

&copy; 2013 abovethewater


