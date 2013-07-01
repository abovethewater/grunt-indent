'use strict'

fs            = require 'fs'

  # ======== A Handy Little Nodeunit Reference ========
  # https://github.com/caolan/nodeunit

  # Test methods:
  #   test.expect(numAssertions)
  #   test.done()
  # Test assertions:
  #   test.ok(value, [message])
  #   test.equal(actual, expected, [message])
  #   test.notEqual(actual, expected, [message])
  #   test.deepEqual(actual, expected, [message])
  #   test.notDeepEqual(actual, expected, [message])
  #   test.strictEqual(actual, expected, [message])
  #   test.notStrictEqual(actual, expected, [message])
  #   test.throws(block, [error], [message])
  #   test.doesNotThrow(block, [error], [message])
  #   test.ifError(value)


exports.indent =
  setUp: (done) ->
    done()

  two_spaces_to_tabs: (test) ->
    test.expect(1)

    expected = fs.readFileSync 'test/expected/tabs.coffee', "UTF-8"

    require('../indents.coffee').run(['coffee', 'indents.coffee', '-s', '2', '-o', 'tmp', 'test/fixtures/two_spaces.coffee'])

    actual = fs.readFileSync 'tmp/two_spaces.coffee', "UTF-8"

    test.equal actual, expected

    test.done()

  three_spaces_to_tabs: (test) ->
    test.expect(1)

    expected = fs.readFileSync 'test/expected/tabs.coffee', "UTF-8"

    require('../indents.coffee').run(['coffee', 'indents.coffee', '-s', '3', '-o', 'tmp', 'test/fixtures/three_spaces.coffee'])

    actual = fs.readFileSync 'tmp/three_spaces.coffee', "UTF-8"

    test.equal actual, expected

    test.done()

