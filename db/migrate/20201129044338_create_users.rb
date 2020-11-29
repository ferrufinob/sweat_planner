class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |type|
      type.string :name
      type.string :email
      type.string :password_digest
    end
  end
end
