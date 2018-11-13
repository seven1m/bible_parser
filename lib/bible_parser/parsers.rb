require_relative 'parsers/base'
require_relative 'parsers/usfx'
require_relative 'parsers/osis'
require_relative 'parsers/zxbml'

class BibleParser
  PARSERS = {
    'USFX' => Parsers::USFX::Parser,
    'OSIS' => Parsers::OSIS::Parser,
    'ZXBML' => Parsers::ZXBML::Parser
  }
end
