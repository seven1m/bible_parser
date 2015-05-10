class BibleParser
  module Parsers
    module USFX
      class Parser < Base::Parser
        def valid?
          (@io.read(1024) =~ /<usfx.*>/i).tap do
            @io.rewind
          end
        end
      end
    end
  end
end
