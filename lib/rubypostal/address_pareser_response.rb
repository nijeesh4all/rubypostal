# frozen_string_literal: true

module Rubypostal
  # AddressParserResponse struct
  class AddressParserResponse < FFI::Struct
    layout :num_components, :size_t,
           :components, :pointer,
           :labels, :pointer
  end
end
