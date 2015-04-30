require_relative 'parsers/base'
require_relative 'parsers/usfx'

class BibleXML
  PARSERS = {
    'USFX' => Parsers::USFX::Parser
  }
end
