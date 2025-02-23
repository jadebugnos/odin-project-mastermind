# this file handles the player class definition
class Player
  attr_accessor :username, :roles

  def initialize(username = nil, role = nil)
    @username = username
    @roles = role
  end

  def set_info(name, role)
    @username = name
    @roles = role
  end
end
