class UserController < ApplicationController
  before_filter :authenticate_user!

  has_many :notes, foreign_key: :owner_id
end
