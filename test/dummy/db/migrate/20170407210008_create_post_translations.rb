class CreatePostTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :post_translations do |t|
      t.string :locale
      t.string :title
      t.references :post

      t.timestamps
    end
  end
end
