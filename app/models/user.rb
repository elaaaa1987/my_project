class User < ActiveRecord::Base
	belongs_to :role

	has_many :attachments, :as => :attachable, :dependent => :destroy

	accepts_nested_attributes_for :attachments, :allow_destroy => true

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
end
