require 'yaml'


@@conf = YAML.load_file(File.join('../cuke-tests/config/data', 'user.yml'))

class Personas

  # Return a hash representing person with person_name
  def self.get_persona person_name
    return @@conf['Personas'][person_name]
  end

end
