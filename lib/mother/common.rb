module Mother
  module Common
    private def ___create(thing)
      Mother.create thing
    end

    private def ___argument_failure!
      raise ArgumentError.new('Must be a hash, or YAML/JSON filename')
    end
  end
end
