module ControllerMacros
  def login_user(user)
    #controller.stub(:authenticate_user!).and_return true
    allow(controller).to receive(:authenticate_user!).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
