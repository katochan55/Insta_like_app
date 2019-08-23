class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :user_name
      t.text :website
      t.text :introduction
      t.string :email
      t.string :phone_number
      t.string :sex

      t.timestamps
    end
  end
end
