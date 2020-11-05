module Validate
  def validate?
    validate!
    true
  rescue
    false
  end
end
