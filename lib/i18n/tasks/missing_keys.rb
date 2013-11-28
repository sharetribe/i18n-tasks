module I18n::Tasks::MissingKeys
  # @return Array missing keys, i.e. key that are in the code but are not in the base locale data
  def keys_missing_from_base
    find_source_keys.reject { |key|
      key_value?(key, base_locale) || pattern_key?(key) || ignore_key?(key, :missing)
    }
  end

  # @return Array keys missing value (but present in base)
  def keys_missing_value(locale)
    traverse_map_if data[base_locale] do |key, base_value|
      key if !key_value?(key, locale) && !ignore_key?(key, :missing)
    end
  end

  # @return Array keys missing value (but present in base)
  def keys_where_value_eq_base(locale)
    traverse_map_if data[base_locale] do |key, base_value|
      key if base_value == t(locale, key) && !ignore_key?(key, :eq_base, locale)
    end
  end

end