class UsersController < Clearance::UsersController

  make_resourceful do
    actions :show
  end

  private
  def current_object
    @current_object ||= User.teachers.find(:first,:conditions => ['username = ? or id = ?', params[:id], params[:id]])
    if @current_object.nil?
      return record_not_found
    end
    return @current_object
  end
end
