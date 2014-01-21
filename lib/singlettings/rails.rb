require "singlettings/base"

module Singlettings
  def self.hook_rails!
    if defined?(::Rails)
      config_path = "#{::Rails.root.to_s}/config/"
      Singlettings.load_yaml_files! config_path
    end
  end

  class Rails < ::Rails::Engine
    # The priorities of ActiveSupport hooks are shown as below:
    # =>  before_configuration
    # =>  before_initialize
    # =>  before_eager_load
    # =>  action_controller
    # =>  action_view
    # =>  active_record
    # =>  after_initialize
    # Since Singlettings is for configuration,
    # it should be loaded before configuration.
    config.before_configuration do
      Singlettings.hook_rails!
    end
  end if defined?(::Rails)

  def self.load_yaml_files!(load_path)
    # Load singletting.yml
    files = []

    singletting = "#{load_path}singletting.yml"
    files << singletting if File.exists?(singletting)

    # Add MyColorWay Flavoured yetting.yml
    yetting = "#{load_path}yetting.yml"
    files << yetting if File.exists? yetting

    # Add namespaced files
    files += Dir.glob("#{load_path}singlettings/**/*.yml")

    files.each do |file|
      Singlettings.eval_yaml file
    end
  end

  # This method needs ActiveSupport
  def self.eval_yaml(file)
    base_name = File.basename(file).gsub(".yml", "").camelize
    if base_name == "Singletting" or base_name == "Yetting"
      klass_name = base_name
    else
      klass_name = "Singletting#{base_name}"
    end
    Object.const_set(klass_name, Singlettings.eval_yaml_class(file))
  end

  # Return specified anonymous class
  def self.eval_yaml_class(file)
    klass = Class.new(Singlettings::Base) do
      source file
      ns ::Rails.env
    end
    return klass
  end
end