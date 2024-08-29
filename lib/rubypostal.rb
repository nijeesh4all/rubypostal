# frozen_string_literal: true

require 'ffi'
require_relative 'rubypostal/libpostal_wrapper'

# The main module for the gem
module Rubypostal
  extend LibpostalWrapper

  def self.parse_address(address)
    options = default_options
    response = parse_address_with_options(address, options)
    results = extract_results(response)
    destroy_response(response)

    results
  end

  class << self
    def self.default_options
      libpostal_get_address_parser_default_options
    end

    def self.parse_address_with_options(address, options)
      libpostal_parse_address(address, options)
    end

    def self.extract_results(response)
      results = {}
      num_components = response[:num_components]

      num_components.times do |i|
        label = response[:labels] + i * FFI::Pointer.size
        component = response[:components] + i * FFI::Pointer.size
        results[label.read_pointer.read_string] = component.read_pointer.read_string
      end

      results
    end

    def self.destroy_response(response)
      libpostal_address_parser_response_destroy(response)
    end
  end
end
