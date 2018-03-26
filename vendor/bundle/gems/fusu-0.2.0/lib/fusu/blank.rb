module Fusu
  module Blank
    def blank?(elem)
      if elem === nil
        true
      elsif elem.class < String
        !!elem.match(/\A[[:space:]]*\z/)
      elsif elem.respond_to?(:empty?)
        elem.empty?
      else
        false
      end
    end
  end
end
