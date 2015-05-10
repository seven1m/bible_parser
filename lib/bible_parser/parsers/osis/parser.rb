class BibleParser
  module Parsers
    module OSIS
      class Parser < Base::Parser
        def valid?
          (@io.read(1024) =~ /<osis.*>/i).tap do
            @io.rewind
          end
        end
      end
    end
  end
end
