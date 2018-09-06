require 'mother/version'
require 'mother/common'
require 'mother/entity'
require 'mother/collection'
require 'yaml'
require 'json'

module Mother
  class << self
    def create(thing)
      case thing
      when Array
        Collection.new thing
      when Hash
        Entity.new thing
      when String
        case
        when thing.match(/\.ya?ml$/)
          self.create YAML.load(File.read(thing))
        when thing.match(/\.json$/)
          self.create JSON.parse(File.read(thing))
        else
          thing
        end
      else
        thing
      end
    end
  end
end
