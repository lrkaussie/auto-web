module CogElements
  class DivButton < PageObject::Elements::Div
    def self.accessor_methods(accessor, name)
      # Adds method to perform click
      accessor.send(:define_method, "#{name}") do
        self.send("#{name}_element").click
      end
    end
  end
  PageObject.register_widget :div_button, DivButton, :div

  class LabelButton < PageObject::Elements::Label
    def self.accessor_methods(accessor, name)
      # Adds method to perform click
      accessor.send(:define_method, "#{name}") do
        self.send("#{name}_element").click
      end
    end
  end
  PageObject.register_widget :label_button, LabelButton, :label

end