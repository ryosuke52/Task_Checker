class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date
    add_column :tasks, :state, :string
    add_column :tasks, :task_info, :text
  end
end
