# frozen_string_literal: true

module Validate
  def validate?
    validate!
    true
  rescue StandardError
    false
  end
end
