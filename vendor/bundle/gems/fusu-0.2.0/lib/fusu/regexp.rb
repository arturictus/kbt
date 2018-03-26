module Fusu
  module Regexp #:nodoc:
    extend self
    # def multiline?(regexp)
    #   regexp.options & MULTILINE == MULTILINE
    # end

    def match?(regexp, string, pos = 0)
      !!regexp.match(string, pos)
    end
  end
end
