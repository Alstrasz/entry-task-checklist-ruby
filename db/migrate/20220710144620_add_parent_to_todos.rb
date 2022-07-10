class AddParentToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :project_id, :bigserial
    add_foreign_key :todos, :projects, name: :project_id
  end
end
