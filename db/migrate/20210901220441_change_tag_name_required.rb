class ChangeTagNameRequired < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tags, :name, false
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
