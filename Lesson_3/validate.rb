# frozen_string_literal: true

module Validate
  def validate?
    validate!
    true
  rescue
    false
  end
end
