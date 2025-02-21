# this file handles the player class definition
class Player
  attr_accessor :username, :role

  def initialize(username, role)
    @username = username
    @role = role
  end
end
