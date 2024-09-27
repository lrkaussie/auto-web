require 'yaml'


@@config = YAML.load_file(File.join('../cuke-tests/config/data', 'products.yml'))

class Products

  # Return a hash representing site country product data
  def self.get_product_data site_country
    return @@config['Products'][site_country]
  end


end