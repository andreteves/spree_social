Spree::UserRegistrationsController.class_eval do

  after_filter :clear_omniauth, :only => :create

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @spree_user = self.resource
      @spree_user.apply_omniauth(session[:omniauth])
      return @spree_user
    else
      return self.resource
    end
  end

  def clear_omniauth
    session[:omniauth] = nil unless @spree_user.new_record?
  end
end
