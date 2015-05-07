require_relative 'parsers/base'
require_relative 'parsers/usfx'
require_relative 'parsers/osis'

class BibleXML
  PARSERS = {
    'USFX' => Parsers::USFX::Parser,
    'OSIS' => Parsers::OSIS::Parser
  }
end
