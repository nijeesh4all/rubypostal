# frozen_string_literal: true

require_relative './address_parser_options'
require_relative './address_pareser_response'

module Rubypostal
  # includes c binding for the libpostal library using FFI
  module LibpostalWrapper
    extend FFI::Library
    ffi_lib 'postal'

    # Setup and teardown functions
    attach_function :libpostal_setup, [], :bool
    attach_function :libpostal_setup_parser, [], :bool
    attach_function :libpostal_teardown, [], :void
    attach_function :libpostal_teardown_parser, [], :void

    # Address parsing functions
    attach_function :libpostal_get_address_parser_default_options, [], AddressParserOptions.by_value
    attach_function :libpostal_parse_address, [:string, AddressParserOptions.by_value], AddressParserResponse.by_ref
    attach_function :libpostal_address_parser_response_destroy, [AddressParserResponse.by_ref], :void

    @mutex = Mutex.new

    @mutex.synchronize do
      raise 'Libpostal setup failed' unless libpostal_setup && libpostal_setup_parser

      @initialized = true
    end

    at_exit do
      @mutex.synchronize do
        if @initialized
          libpostal_teardown
          libpostal_teardown_parser
        end
      end
    end
  end
end
