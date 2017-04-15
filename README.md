# Art
ActiveRecord Translated

ART was created to translate ActiveRecord models with the minimum footprint
possible.

* Built on public AR and i18n features (NO monkey patches), so easy to upgrade.
* Super simple, easy to grok, hard to break.

It consists of basically a few macros and a wee bit of metaprogramming.
Translations are stored in a single table.  These are lazy-looked up and cached
in memory, so both simple and wicked-fast.
A simple 
Short description and motivation.

Currently (as of 2017/4/15), it is still very much alpha but I am using it in
production as I develop it. 

## Requirements
ART is being developed against Rails/ ActiveRecord 5.1, but should work fine with 
Rails 4.

## Usage
ART works by using a separate model for each translated model with 'Translation'
appended to it.  It must have a string field called `locale` and a reference to the
parent table.  For example, if you have an Essay model, you would need a model 
called EssayTranslation, with `essay_id` and `locale` fields in it plus any field 
names that you want translated (title, description etc).

In the Essay model, you would specify:
    
    class Essay < ApplicationRecord
      translated :title, :description
    end

    class EssayTranslation < ApplicationRecord
      translates
    end

Art will set up a `has_many` relationship for the translation table and will delegate
    :title, :title=, :description, :description=
to the translation table.  It also creates a scoped association called `translator`
which references the translation table with `@current_locale` if set or I18n.locale.

To access translations:

    essay = Essay.first
    I18n.locale = :ja
    essay.title
    # => 'My Dog' 
    essay.title
    # => '私の犬' 

You can also override this by specifying the instance variable `@current_locale`:
    @current_locale = :fr
    essay.title
    # => 'Ma Chien' 

To set translations:
    essay = Essay.new(word_count: 27, created_date: Date.new(2017,1,12), title: 'foo', description: 'bar')
    essay.save
This creates the translation as well and sets the translated fields for the I18n.locale.
To add another locale, simply do:
    @current_locale=:ja
    essay(title: 'タイトル', description: '内容')
    essay.save


## Installation
Add this line to your application's Gemfile:
gem 'art'

```ruby
gem 'art'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install art
```

## Contributing
I am happy to include contributions with the following caveats.
1. Code must be simple and difficult to break.
2. Nothing goes in without a test. 
3. No modification of internals of dependencies (ActiveRecord, ActiveModel,
   I18n etc).  Only public API's.
If in doubt, post an issue about what you would like to include before writing it.

## License
The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

