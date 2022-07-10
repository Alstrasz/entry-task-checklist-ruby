class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, index: { unique: true }

      t.timestamps
    end
  end
end
