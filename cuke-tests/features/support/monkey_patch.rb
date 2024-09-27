module PageObject
  module Accessors
    def standard_methods(name, identifier, method, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.send(method, identifier.clone)
      end
      define_method("present_#{name}?") do
        return call_block(&block).present? if block_given?
        platform.send(method, identifier.clone).present?
      end
    end
  end
end