class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :notes, foreign_key: :owner_id
  has_many :month_note_lists, foreign_key: :owner_id
  has_many :tags, foreign_key: :owner_id

  def findOrCreateForNote(note)
    found = nil;
    self.month_note_lists.all.each do |m|
      if (m.date.month == note.date.month &&
          m.date.year == note.date.year)
        found = m
      end
    end

    if found.nil?
      found = MonthNoteList.new
      found.owner_id = self.id
      found.date = Date.new(note.date.year, note.date.month, 1)
    end

    found
  end

  def displayedMonths
    allMonthlyNotes = self.month_note_lists.to_a
    allMonthlyNotes.sort_by! {|m| m[:date]}
    allMonthlyNotes.reverse!
    allMonthlyNotes
  end
end
