class BibleParser
  module Parsers
    module ZXBML
      class Parser < Base::Parser
        def valid?
          (@io.read =~ /<format>Zefania XML Bible Markup Language<\/format>/i).tap do
            @io.rewind
          end
        end
      end
    end
  end
end
