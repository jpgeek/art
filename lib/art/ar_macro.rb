module Art
  module ArMacro

    def self.extended(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def translated(*attributes)
        self.extend(TranslatesClassMethods)
        setup_attributes!(attributes)
        setup_current_locale!
        setup_translator_relation!
      end

      def translator
        self.extend(TranslatesClassMethods)
        translator_class.send(:belongs_to, translated_relation_name.to_sym)
      end


      protected
      def setup_translator_relation!
        translated_class.send(:has_many, translator_relation_name.to_sym)
        translated_class.instance_eval{
          name = translator_class_name
          has_one(
            :translator_proxy, 
            ->(translator_object) {where(locale: translator_object.current_locale)},
            {class_name: "PostTranslation"}
          )
        }
            # {class_name: "#{translator_class_name}"}
      end

      def setup_attributes!(attributes)
        @translated_attributes ||= []
        attrs = attributes.map(&:to_sym)
        attrs.each do |attr|
          @translated_attributes << attr
          delegate attr, to: :translator_proxy
        end
      end

      def setup_current_locale!
        self.class_eval do
          def current_locale
            @current_locale || I18n.locale
          end
        end
      end

      def translated_class_name
        self.name.gsub(/Translation$/,'')
      end

      def translated_class
        translated_class_name.constantize
      end

      def translated_relation_name
        translated_class_name.underscore
      end


      def translator_class_name
        return self.name if self.name.match /Translation$/
        "#{self.name}Translation"
      end

      def translator_class
        translator_class_name.constantize
      end

      def translator_relation_name
        translator_class_name.underscore.pluralize
      end

      def translator_table_name
        translator_relation_name
      end
    end

    #def translated_set_up?
    #  singleton_class.included_modules.include?(TranslatedClassMethods)
    #end

    #def translator_set_up?
    #  translation_class.singleton_class.included_modules.include?(
    #    TranslatesClassMethods)
    #end

    module TranslatesClassMethods
    end

    module TranslatedClassMethods
    end

  end
end
