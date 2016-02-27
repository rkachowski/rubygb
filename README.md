# rubygb [![[version]](https://badge.fury.io/rb/rubygb.svg)](http://badge.fury.io/rb/rubygb)  [![[travis]](https://travis-ci.org/rkachowski/rubygb.png)](https://travis-ci.org/rkachowski/rubygb)

Bundles the [rgbds-linux](https://github.com/bentley/rgbds) compiler (for OSX) along with some helpful libs from galp to create and build gameboy roms in a quick and stupid way.


## Setup

Install from rubygems

```ruby
gem install rubygb
```

## Usage

```
$ rubygb init you
Creating new project at /Users/cooldev/you
Copying gbhw.inc...
Copying ibmpx1.inc...
Copying memory.inc...
Generating you/you.s...
Done!

$ cd you

$ rubygb build you.s
Assembling you.s
Pass 1...
Pass 2...
Success! 3283 lines in 0.01 seconds (13894335 lines/minute)

$ gameboyemulator --open you.gb
```

![despite everything, it's still you](wiki-images/you.gif)

## Awesomeness

All the cool parts are from other people

* [rgbds-linux](https://github.com/bentley/rgbds)
* [gameboy assembly language primer (galp)](http://www.devrs.com/gb/docs.php) - devrs.com


## MIT License

Copyright (C) 2016 Donald Hutchison <donaldhutchison.info>. Released under the MIT license.
