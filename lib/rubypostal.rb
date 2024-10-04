# frozen_string_literal: true

require "ffi"
require_relative "rubypostal/libpostal_wrapper"

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

  def self.expand_address(address)
    raise "Libpostal setup failed" unless libpostal_setup && libpostal_setup_language_classifier

    # Setup options and initialize the count for expansions
    options = libpostal_get_default_options
    num_expansions_ptr = FFI::MemoryPointer.new(:size_t)

    # Call expand_address and get the result
    expansions_ptr = libpostal_expand_address(address, options, num_expansions_ptr)
    num_expansions = num_expansions_ptr.read(:size_t)

    # Manually read the array of strings
    expansions = num_expansions.times.map do |i|
      expansions_ptr.get_pointer(i * FFI.type_size(:pointer)).read_string
    end

    # Cleanup memory
    libpostal_expansion_array_destroy(expansions_ptr, num_expansions)

    expansions
  end

  class << self
    def default_options
      libpostal_get_address_parser_default_options
    end

    def parse_address_with_options(address, options)
      libpostal_parse_address(address, options)
    end

    def extract_results(response)
      results = {}
      num_components = response[:num_components]

      num_components.times do |i|
        label = response[:labels] + i * FFI::Pointer.size
        component = response[:components] + i * FFI::Pointer.size
        results[label.read_pointer.read_string] = component.read_pointer.read_string
      end

      results
    end

    def destroy_response(response)
      libpostal_address_parser_response_destroy(response)
    end
  end
end
