require "mother/version"

class Mother
  attr_accessor :data

  def initialize(argument)
    @data =
    case argument
    when Hash
      argument
    when String
      case
      when argument.match(/\.ya?ml$/)
        YAML.load(File.read(argument))
      when argument.match(/\.json$/)
        JSON.parse(File.read(argument))
      else
        ___argument_failure!
      end
    else
      ___argument_failure!
    end
  end

  def [](key)
    child = ___fetch key
    case child
    when Hash
      self.class.new child
    else
      child
    end
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

  def ___argument_failure!
    raise ArgumentError.new('Must be a hash, or YAML/JSON filename')
  end
end
