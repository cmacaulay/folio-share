require "delegate"

class UserDecorator < SimpleDelegator
  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end

  def first
    self.first_name.capitalize
  end
end
