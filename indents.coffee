fs            = require 'fs'
path          = require 'path'
commander     = require 'commander'
coffeelint    = require 'coffeelint'

config =

version = JSON.parse(fs.readFileSync(path.join(__dirname, 'package.json'))).version

TABS_REGEX = /\t/g
SPACES = "    "
DEFAULT_LINTER = "coffeelint"
LINTER_DIR = "linters"

configure =(options={}) ->

  config =
    sources: options.args
    output: options.output

  fs.mkdirSync options.output if config.output and not fs.existsSync options.output

  options.linter or= DEFAULT_LINTER

  lintOptions = JSON.parse(fs.readFileSync(path.join(__dirname, "#{LINTER_DIR}/#{options.linter}.json")))

  config.preLintOptions = {}
  config.postLintOptions = {}

  config.preLintOptions[key] = value for own key,value of lintOptions
  config.postLintOptions[key] = value for own key,value of lintOptions

  preLintOptions = {}
  postLintOptions = {}


  if options.spacestotabs
    preLintOptions =
      "no_tabs":
        "level": "error"
      "indentation":
        "level": "error",
        "value": parseInt options.spacestotabs
    postLintOptions =
      "no_tabs":
        "level": "ignore"
      "indentation":
        "level": "error",
        "value": 1
    config.from = ""
    config.to = "	"

    # **Crazily fragile**
    # Why does "\s\s" or \s{2} not work?
    # End up wth "^I " rather than "^I"
    config.from += " " for [0...options.spacestotabs]
    config.from = new RegExp(config.from, "g")

  else
    preLintOptions =
      "no_tabs":
        "level": "ignore"
      "indentation":
        "level": "error",
        "value": 1
    postLintOptions =
      "no_tabs":
        "level": "error"
      "indentation":
        "level": "error",
        "value": parseInt options.tabstospaces or= 2
    config.from = TABS_REGEX
    config.to = ""

    config.to += " " for [0...options.tabstospaces or= 2]

  config.preLintOptions[key] = value for own key,value of preLintOptions
  config.postLintOptions[key] = value for own key,value of postLintOptions

  return config

convert =(options ={}) ->

  config = configure options

  files = config.sources.slice()

  nextFile = ->

    source = files.shift()

    buffer = fs.readFileSync source

    code = buffer.toString()
    handleLintOutput source, "pre", coffeelint.lint code, config.preLintOptions

    codeOut = indents config, code
    handleLintOutput source, "post", coffeelint.lint codeOut, config.postLintOptions

    if config.output
      output = "#{config.output}/#{path.basename source}"
    else
      output = source

    write source, output, codeOut

    nextFile() if files.length

  nextFile()

indents = (options, code) ->

  options or=
    from : /\t/g
    to : "    "
    preLintOptions :
      "no_tabs":
        "level": "ignore"
      "indentation":
        "level": "error",
        "value": 1
    postLintOptions :
      "no_tabs":
        "level": "error"
      "indentation":
        "level": "error",
        "value": 4

  lines = code.split /(?=\n)/

  output = ''

  nextLine = ->

    line = lines.shift()

    output+= line.replace(options.from, options.to)

    nextLine() if lines.length

  nextLine()

  output

handleLintOutput = (source, stage, errors) ->

  console.error "#{source}: #{ stage } Linting failed with the following" if errors.length

  for error in errors
    console.error error if error.level is 'error'
    console.warn error if error.level is 'warn'

  process.exit 1 if errors.length


write = (source, dest, code) ->

  console.log "#{source} -> #{dest}"

  fs.writeFileSync(dest, code)


run = (args = process.argv) ->
  c = config
  commander.version(version)
    .usage('[options] files')
    .option('-l, --linter [linter]',    'use linter config', c.linter)
    .option('-t, --tabstospaces [spaces]',    'convert indentation from tabs to spaces', c.tabstospaces)
    .option('-s, --spacestotabs [spaces]',    'convert indentation from spaces to tabs', c.spacestotabs)
    .option('-o, --output [path]',    'output to a given folder', c.output)
    .parse(args)
    .name = "indents"
  if commander.args.length
    convert commander
  else
    console.log commander.helpInformation()

Indents = module.exports = {run}
