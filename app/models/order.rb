class Order < ApplicationRecord
  validates :submission_format, presence: true
end
