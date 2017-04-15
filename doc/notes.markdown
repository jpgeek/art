# TODO

  Create git repo, push

  Translate uses :delegate with the translator_proxy.

  fix tests: add :ja to valid locales
  test `current_locale` switch

  Add and test options to relations: 
    inverse_of
    dependent
    autosave

  Add validations, nesting:
    validates :trans, :presence => {:minimum => 1}
    validates_associated :trans
    accepts_nested_attributes_for :trans
      

# design

A translation table for each translated class
Models delegate to Art

http://guides.rubyonrails.org/plugins.html#setup
