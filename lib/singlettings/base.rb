require 'singlettings/exceptions'
require 'yaml'

require 'erb'
module Singlettings
  class Base < Hash
    attr_reader :source, :ns
    class << self
      # Basic Usage of source in class
      #   source "config/setting.yml"
      #   source
      def source(directory = nil)
        filename = directory ? directory : "#{self.ancestors[0].to_s.downcase}.yml"
        @erb_content = ERB.new(File.read(filename)).result # Set it in memory
        @source = @erb_content ? YAML.load(@erb_content) : {}
      end

      # Set the default namespace
      # Basic Usage of ns in class:
      # ns :development
      # ns Rails.env
      def ns(value = nil)
        @ns = value.to_s if value
      end

      # Override the hash method
      def [](key)
        value = current_branch.fetch key.to_s, nil
        if value.is_a? Hash
          self.new value
        else
          value
        end
      end

      def current_branch
        source unless @source
        return @source unless @ns
        if @source[@ns] == nil
          raise NoSuchNamespaceError, "Source is empty. The namespace does not exist"
        else
          @source[@ns]
        end
      end

      def method_missing(method, *args, &block)
        key = method.to_s
        if current_branch.keys.include? key
          value = current_branch[key]
          if value.is_a? Hash
            self.new value
          else
            value
          end
        else
          raise NoSuchKeyError, "#{key} does not exist"
        end
      end
    end # class self

    def initialize(directory_or_hash, default_namespace= nil)
      @ns = self.class.ns default_namespace

      raise FileNotSpecifiedError, "You should choose a file to initialize" unless directory_or_hash

      if directory_or_hash.is_a? Hash
        @source = directory_or_hash
      else
        @source = self.class.source directory_or_hash
      end

      self.replace current_branch
    end

    def current_branch
      return source unless ns
      if source[ns] == nil
        raise NoSuchNamespaceError, "Source is empty. The namespace does not exist"
      else
        source[ns]
      end
    end

    def [](key)
      value = current_branch.fetch key.to_s, nil
      if value.is_a? Hash
        self.class.new value
      else
        value
      end
    end

    def method_missing(method, *args, &block)
      key = method.to_s
      if current_branch.keys.include? key
        value = current_branch[key]
        if value.is_a? Hash
          self.class.new value
        else
          value
        end
      else
        raise NoSuchKeyError, "#{key} does not exist"
      end
    end
  end

end