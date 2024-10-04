module Rubypostal
  class AdressNormalizeOptions < FFI::Struct
    layout(
      :languages, :pointer,
      :num_languages, :size_t,
      :address_components, :uint32,
      :latin_ascii, :bool,
      :transliterate, :bool,
      :strip_accents, :bool,
      :decompose, :bool,
      :lowercase, :bool,
      :trim_string, :bool,
      :replace_numeric_hyphens, :bool,
      :delete_numeric_hyphens, :bool,
      :split_alpha_from_numeric, :bool,
      :delete_final_periods, :bool,
      :delete_acronym_periods, :bool,
      :drop_english_possessives, :bool,
      :delete_apostrophes, :bool,
      :expand_numex, :bool,
      :roman_numerals, :bool
    )
  end
end
