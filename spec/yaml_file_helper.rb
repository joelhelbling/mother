require 'yaml'
require 'json'

module YamlFileHelper
  def write_yaml(filename, hash)
    File.open(filename, 'w') do |fh|
      fh.write hash.to_yaml
    end
  end

  def write_json(filename, hash)
    File.open(filename, 'w') do |fh|
      fh.write hash.to_json
    end
  end
end
