require 'yaml'


@@order_details_yml = YAML.load_file(File.join('../cuke-tests/config/data', 'order_details.yml'))

class Orderinfo

  # Return a hash representing site country product data
  def self.get_orderinfo
    return @@order_details_yml['order_details']
  end

end