module Fusu
  module Try
    def try(object, *a, &b)
      return nil if object === nil
      try!(object, *a, &b) if a.empty? || object.respond_to?(a.first)
    end

    def try!(object, *a, &b)
      if a.empty? && block_given?
        if b.arity == 0
          object.instance_eval(&b)
        else
          yield object
        end
      else
        object.public_send(*a, &b)
      end
    end
  end
end
