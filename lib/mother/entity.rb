module Mother
  class Entity
    include Mother::Common

    def initialize(argument)
      ___argument_failure! unless argument.is_a?(Hash)

      @data = argument
    end

    def [](key)
      ___create ___fetch(key)
    end

    def keys
      @data.keys
    end

    def method_missing(method, *args, &block)
      self[method]
    end

    private

    def ___fetch(key)
      @data[key.to_sym] or @data[key.to_s]
    end
  end
end
