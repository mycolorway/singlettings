require "singletting/base"

module Singletting
  def self.hook_rails!
    if defined?(::Rails)
      config_path = "#{::Rails.root.to_s}/config/"
      Singletting.load_yaml_files!
    end
  end

  class Rails < ::Rails::Engine
    initializer 'singletting' do
      Singletting.hook_rails!
    end
  end if defined?(::Rails)

  private
  def self.load_yaml_files! (load_path)
    main_file = "#{load_path}/singletting.yml"
    ns_files = Dir.glob("#{load_path}singlettings/**/*.yml")
    files = [main_file] + ns_files
    files.each do |file|
      Singletting.eval_yaml file
    end
  end

  # This method needs ActiveSupport
  def eval_yaml(file)
    base_name = File.base(file).gsub(".yml","").camelize
    klass_name = "#{base_name}Singletting" unless base_name=="Singletting"
    Object.const_set(klass_name, Singletting.eval_yaml_class(file))
  end

  def eval_yaml_class(file)
    klass = Class.new(Singletting::Base) do
      source file
      ns Rails.env
    end
    return klass
  end
end