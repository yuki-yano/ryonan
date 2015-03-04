require 'erb'
require 'ostruct'
require 'active_support/core_ext/string/inflections'

module Ryonan
  class Renderer < OpenStruct
    def render(template)
      ERB.new(template).result(binding)
    end
  end
end
