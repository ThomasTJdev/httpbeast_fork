# FORK OF HTTPBEAST

A fork of `httpbeast` updated to work with Nim version 2.0. Package has been renamed to `httpbeastfork`.

**Reason:**
* Package not being tagged (new versions not available)
* Full support for Nim 2.0

**Jester & httpbeast:**
* This package can be used with the original [`jester`](https://github.com/dom96/jester/tree/master) package, but it is
  recommended to use the fork [`jesterfork`](https://github.com/ThomasTJdev/jester_fork) instead.

**Breaking changes / Info:**
* Package renamed to `httpbeastfork` from version 1.0.0. Previous versions
  (tags) uses the original package name `httpbeast`.
* The previous tag, `v0.4.2`, includes the needed fixes to allow the
  original `jester` package to work with Nim 2.0.
* This fork is a spin-off of the original `httpbeast` package `v0.4.0`.
  The original package is still available but does not support Nim 2.0.
* Nim support bumped to `>= 1.4.8`

# httpbeastfork

A highly performant, multi-threaded HTTP 1.1 server written in Nim.

The main goal of this project is performance, when it was started the goal was to get the fastest possible HTTP server written in pure Nim, it has held the title of the fastest Nim HTTP server since its initial release. In 2018 HttpBeast reached the [top 10 in the TechEmpower benchmarks](https://www.techempower.com/benchmarks/#section=data-r18&hw=ph&test=json) beating many established HTTP servers implemented in other programming languages. Httpbeast has been used successfully in many projects, for example the [Nim Forum](https://forum.nim-lang.org).

> :information_source: Unless you know what you're doing (for example writing something resource constrained or your own web framework), you are better off using [Jester](https://github.com/dom96/jester) (which is built on Httpbeast) or another web framework.

> :information_source: This HTTP server has been designed to utilise epoll-like OS APIs and as such does not support Windows by-design.

> :warning: This library is not yet hardened against common HTTP security exploits. If you're using it in production you should do so behind a reverse proxy like nginx.

## Features

Current features include:

* Built on the Nim ``selectors`` module which makes efficient use of epoll on
  Linux and kqueue on macOS.
* Automatic parallelization, just make sure to compile with ``--threads:on``.
* Support for HTTP pipelining.
* On-demand parser so that only the requested data is parsed.
* Integration with Nim's ``asyncdispatch`` allowing async/await to be used in
  the request callback whenever necessary.


## Getting started

Create a `helloHttp.nimble` file:

```
# Package

version       = "0.1.0"
author        = "Your Name"
description   = "Your Description"
license       = "MIT"
srcDir        = "src"
bin           = @["helloHttp"]


# Dependencies

requires "nim >= 1.0.0"
requires "httpbeastfork >= 0.4.0"
```

Create a `src/helloHttp.nim` file:

```nim
import options, asyncdispatch

import httpbeastfork

proc onRequest(req: Request): Future[void] =
  if req.httpMethod == some(HttpGet):
    case req.path.get()
    of "/":
      req.send("Hello World")
    else:
      req.send(Http404)

run(onRequest)
```

Run via: `nimble c -r helloHttp.nim`
