require 'art/ar_macro'

module Art
  #autoload :ArMacro, 'art/ar_macro'
end

ActiveRecord::Base.extend(Art::ArMacro)
