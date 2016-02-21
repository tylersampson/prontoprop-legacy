class Account < ActiveRecord::Base
  validates :name, :database, presence: true
  validates :database, uniqueness: true
  validates :database, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
