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
  tearDown: (done) ->
    done()
  tabs_to_spaces_default: (test) ->
    test.expect(1)

    expected = fs.readFileSync 'test/expected/default_options.coffee', "UTF-8"

    require('../indents.coffee').run(['coffee', 'indents.coffee', '-o', 'tmp', 'test/fixtures/tabs.coffee'])

    actual = fs.readFileSync 'tmp/tabs.coffee', "UTF-8"

    test.equal actual, expected

    test.done()

  tabs_to_spaces_non_default: (test) ->
    test.expect(1)

    expected = fs.readFileSync 'test/expected/two_spaces.coffee', "UTF-8"

    require('../indents.coffee').run(['coffee', 'indents.coffee', '-t', '2', '-o', 'tmp', 'test/fixtures/tabs.coffee'])

    actual = fs.readFileSync 'tmp/tabs.coffee', "UTF-8"

    test.equal actual, expected

    test.done()

  tabs_to_spaces_three_spaces: (test) ->
    test.expect(1)

    expected = fs.readFileSync 'test/expected/three_spaces.coffee', "UTF-8"

    require('../indents.coffee').run(['coffee', 'indents.coffee', '-t', '3', '-o', 'tmp', 'test/fixtures/tabs.coffee'])

    actual = fs.readFileSync 'tmp/tabs.coffee', "UTF-8"

    test.equal actual, expected

    test.done()

