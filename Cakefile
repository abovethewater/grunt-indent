{spawn, exec} = require 'child_process'
fs            = require 'fs'
path          = require 'path'

option '-p', '--prefix [DIR]', 'set the installation prefix for `cake install`'

task 'install', 'install the `indents` command into /usr/local (or --prefix)', (options) ->
  base = options.prefix or '/usr/local'
  lib  = base + '/lib/indents'
  exec([
    'mkdir -p ' + lib
    'cp -rf bin/indents README.md *.coffee ' + lib
    'ln -sf ' + lib + '/bin/indents ' + base + '/bin/indents'
  ].join(' && '), (err, stdout, stderr) ->
   if err then console.error stderr
  )
