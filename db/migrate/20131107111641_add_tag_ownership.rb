class AddTagOwnership < ActiveRecord::Migration
  def up
    add_column :tags, :owner_id, :integer

    tags = Tag.find(:all)
    tags.each do |tag|
      tag.owner_id = 1;
      tag.save      
    end
  end
  
  def down
    remove_column :tags, :owner_id
  end
end
