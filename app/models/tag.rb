class Tag < ActiveRecord::Base
  belongs_to :owner, class_name: User

  has_and_belongs_to_many :notes

  def summarize
    str = String.new
    str = self.name
#    str += "(" + String.new(self.notes.size) + " Notes)"
    str
  end
end
