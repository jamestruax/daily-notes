class Note < ActiveRecord::Base
  belongs_to :owner, class_name: User

  has_and_belongs_to_many :tags
  
  def summarize
    str = String.new
    str = self.description.slice(0, 50)
    str += " ..."
    str
  end
end
