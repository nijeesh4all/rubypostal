# frozen_string_literal: true

module Rubypostal
  # AddressParserOptions struct
  class AddressParserOptions < FFI::Struct
    layout :language, :string,
           :country, :string,
           :minimize_components, :bool,
           :geocode, :bool
  end
end
