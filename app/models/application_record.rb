class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :not_deleted, -> { where(is_deleted: false) }
  scope :ordered, ->(type = :asc) { order(created_at: type) }
end
