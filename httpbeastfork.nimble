# Package

version       = "1.0.0"
author        = "Dominik Picheta"
description   = "A super-fast epoll-backed and parallel HTTP server [FORK for nim v2.x.x]"
license       = "MIT"

srcDir = "src"

# Dependencies

requires "nim >= 1.4.8"

# Test dependencies
requires "asynctools#0e6bdc3ed5bae8c7cc9"

task helloworld, "Compiles and executes the hello world server.":
  exec "nim c -d:release --gc:boehm -r tests/helloworld"

task dispatcher, "Compiles and executes the dispatcher test server.":
  exec "nim c -d:release --gc:boehm -r tests/dispatcher"

task test, "Runs the test suite.":
  exec "nimble c -y -r tests/tester"
