class Role < ActiveRecord::Base
	has_many :users, :dependent => :destroy
	validates :name, presence: true
end
