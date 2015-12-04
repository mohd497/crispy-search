module ApplicationHelper

  def bootstrap_class_for(flash_type)
    { success: 'success', error: 'danger',
        alert: 'warning', notice: 'info' }[flash_type.to_sym]
  end


  def user_avatar
    if current_user.avatar
      image_tag current_user.avatar, class: 'img-circle', height: 35
    else
      image_tag 'default_avatar.png', height: 35
    end
  end

  def external_link(link)
    link =~ /^https?:\/\// ? link : "http://#{link}"
  end
end
