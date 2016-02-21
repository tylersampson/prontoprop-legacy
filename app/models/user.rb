class User < ActiveRecord::Base
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  def self.current_id=(id)
    Thread.current[:user_id] = id
  end

  def self.current_id
    Thread.current[:user_id]
  end

end
