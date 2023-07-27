class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.string :state
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
