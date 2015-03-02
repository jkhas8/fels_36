module ActivitiesHelper
  def get_user_name user_id
    user = User.find user_id
    link_to current_user?(user) ? "You" : user.name, user
  end

  def get_category_by_lession lession_id
    Lession.find(lession_id).category
  end
end
