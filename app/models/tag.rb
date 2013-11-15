class Tag < ActiveRecord::Base
  belongs_to :owner, class_name: User

  has_and_belongs_to_many :notes

  def summarize
    str = String.new
    str = self.name
    str
  end

  def displayedNotes
    notes = self.notes.sort_by! {|n| [n.date, n.time]}
    notes.reverse!
    notes
  end

end
