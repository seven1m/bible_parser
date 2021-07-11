# BibleParser

[![Build Status](https://travis-ci.org/seven1m/bible_parser.svg?branch=master)](https://travis-ci.org/seven1m/bible_parser)

This is a Ruby library for parsing different bible XML formats.

We currently support:

- USFX (for USFM, see 'Other Tools' below)
- OSIS
- Zefania

## Install

```
gem install bible_parser
```

## Use

You can get a bible version in XML format [here](https://github.com/seven1m/open-bibles).

```ruby
require 'bible_parser'

bible = BibleParser.new(File.open('web.usfx.xml'))
verse = bible.books.first.chapters.first.verses.first
# => <Genesis 1:1>
verse.text
# => "In the beginning, God created the heavens and the earth.\n"
```

## License

Copyright (c) Tim Morgan. Licensed MIT. See LICENSE file.

## Other Tools

- [u2o](https://github.com/adyeths/u2o) - Python script to convert from USFM (a format our library does not support) to OSIS (an XML format we do support)
