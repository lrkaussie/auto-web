require 'yaml'


@@sites_yml = YAML.load_file(File.join('../cuke-tests/config/environments', 'sites.yml'))
@@devsites_yml = YAML.load_file(File.join('../cuke-tests/config/environments', 'dev.yml'))

class Siteinfo

  # Return a hash representing site country product data
  def self.get_siteinfo site_country
    return @@sites_yml['Siteinfo']
  end

  def self.get_devsiteinfo site_country
    return @@devsites_yml['Devsiteinfo']
  end

end