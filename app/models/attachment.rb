class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attached_file :attachment, :styles => { :medium => "150x150", :small => "80x80" } ,
                     :url  => "/assets/attachments/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/attachments/:id/:style/:basename.:extension"
  validates_attachment :attachment, content_type: { content_type: ["image/png", "image/jpg", "image/jpeg"] }
end
