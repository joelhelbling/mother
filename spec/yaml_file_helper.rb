require "yaml"
require "json"

module YamlFileHelper
  def write_yaml(filename, hash)
    File.write(filename, hash.to_yaml)
  end

  def write_json(filename, hash)
    File.write(filename, hash.to_json)
  end
end
