module ActivitiesHelper
  def get_user user
    user_name =  current_user?(user) ? "You" : user.name
    link_to gravatar_for(user, size: 25, name: user_name) +
            content_tag(:b, user_name), user
  end
end
