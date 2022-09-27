module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(attribute, type_validation, arg = nil)
      @validations ||= {}
      @validations[attribute] ||= []
      @validations[attribute] << [type_validation, arg]
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |attr_name, validations|
        validations.each { |v| send("validate_#{v[0]}", attr_name, *v[1]) }
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(name)
      raise "#{name} is empty!" if send(name.to_s).to_s.empty?
    end

    def validate_format(name, format)
      raise "#{name} is not #{format} format" if send(name.to_s).to_s !~ format
    end
  end
end
