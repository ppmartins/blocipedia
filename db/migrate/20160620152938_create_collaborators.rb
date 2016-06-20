class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.timestamps
    end

    create_table :wikis do |t|
      t.string :title
      t.timestamps
    end

    create_table :collaborators, id: false do |t|
      t.integer :user_id
      t.integer :wiki_id
    end

    add_index :users, :id, unique: true
    add_index :wikis, :id, unique: true
    add_index :collaborators, :id, unique: true
    add_index :collaborators, :user_id
    add_index :collaborators, :wiki_id
  end
end
