require "mother/version"
require "mother/collection"
require "yaml"
require "json"

class Mother
  attr_reader :data

  def initialize(argument)
    self.class.argument_failure! unless argument.is_a?(Hash)

    @data = argument
  end

  def [](key)
    self.class.create ___fetch(key)
  end

  def keys
    @data.keys
  end

  def values
    @data.values
  end

  def method_missing(method, *args, &block)
    self[method]
  end

  def respond_to_missing?(method, include_private = true)
    keys.include?(method) || keys.include?(method.to_s) || super
  end

  private

  def ___fetch(key)
    @data[key.to_sym] or @data[key.to_s]
  end

  class << self
    def create(thing)
      case thing
      when Array
        Collection.new self, thing
      when Hash
        new thing
      when String && /\.ya?ml$/
        create YAML.load(File.read(thing))
      when String && /\.json$/
        create JSON.parse(File.read(thing))
      else
        thing
      end
    end

    def argument_failure!
      raise ArgumentError.new("Must be a hash, or YAML/JSON filename")
    end
  end
end
