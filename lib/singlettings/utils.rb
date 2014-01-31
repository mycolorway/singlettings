module Singlettings
  module Utils
    extend self

    def underscore(str)
      str.gsub(/(.)([A-Z])/) {
        "#{$1}_#{$2.downcase}"
        }.downcase
    end

    def camelize(str)
      str.split('_').map(&:capitalize).join
    end
  end
end