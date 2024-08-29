require 'ffi'
require 'thread'

require_relative 'rubypostal/libpostal_wrapper'

module Rubypostal
  extend LibpostalWrapper

  def self.parse_address(address)
    options = libpostal_get_address_parser_default_options()
    response = libpostal_parse_address(address, options)

    results = {}
    num_components = response[:num_components]

    num_components.times do |i|
      label = response[:labels] + i * FFI::Pointer.size
      component = response[:components] + i * FFI::Pointer.size
      results[label.read_pointer.read_string] = component.read_pointer.read_string
    end

    libpostal_address_parser_response_destroy(response)

    results
  end
end
