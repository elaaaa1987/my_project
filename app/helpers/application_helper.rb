module ApplicationHelper
	def get_user_image(user)
		all_images = []
		unless user.attachments.empty?
			user.attachments.each do |img|
				all_images << image_tag(img.attachment.url(:small))
			end
			all_images.join("</br></br>").html_safe
		end
	end
end
