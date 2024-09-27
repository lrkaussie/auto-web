require 'yaml'


@@con = YAML.load_file(File.join('../cuke-tests/config/data', 'payment.yml'))

class Payment

  # Return a hash representing person with person_name
  def self.get_payment_info payment_method
    return @@con['Payment'][payment_method]
  end

end