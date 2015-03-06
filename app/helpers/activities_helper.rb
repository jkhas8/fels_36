module ActivitiesHelper
  def get_user user_id
    user = User.find user_id
    user_name =  current_user?(user) ? "You" : user.name
    link_to gravatar_for(user, size: 25, name: user_name) + user_name, user
  end

  def get_category_by_lession lession_id
    Lession.find(lession_id).category
  end
end
