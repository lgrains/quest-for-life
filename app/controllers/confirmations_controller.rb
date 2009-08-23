class ConfirmationsController < Clearance::ConfirmationsController
  private
  def url_after_create
    current_user
  end
end
