class Object
  def try(method, *args, &block)
    send(method, *args, &block)
  end
  remove_method :try
  alias_method :try, :__send__
end

class NilClass
  def try(*args)
    nil
  end
end