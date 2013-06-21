# USFX

This is a very simple SAX Document and Nokogiri SAX Parser for reading Unified Scripture Format XML (USFX) files as a stream and doing something interesting with the verse data.

I needed to get the World English Bible (WEB) into a database easily and efficiently, so this was born. This parser excludes footnotes and other content other than the verse text itself, which may or may not be what you want.

Pull requests welcome!

## Install

```
gem install usfx
```

## Use

You can get the World English Bible (WEB) in USFX format [here](http://ebible.org/web/). Unzip and put the usfx.xml file somewhere.

```ruby
class MyDocument < USFX::Document
  def verse(data)
    # do something with verse data, which looks like:
    # {
    #   book_num: 1,
    #   book_id: 'GEN',
    #   book: 'Genesis',
    #   chapter: 1,
    #   verse: 1,
    #   text: 'In the beginning, God created the heavens and the earth.'
    # }
  end
end

parser = USFX::Parser.new(MyDocument.new)
parser.parse(File.open('eng-web_usfx.xml'))
```

## License

Copyright (c) 2013 Tim Morgan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
