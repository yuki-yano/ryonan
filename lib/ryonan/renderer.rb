require 'erb'
require 'ostruct'

module Ryonan
  class Renderer < OpenStruct
    def render(template)
      ERB.new(template).result(binding)
    end
  end
end
