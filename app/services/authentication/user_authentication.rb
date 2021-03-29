module Authentication
  class UserAuthentication
    def initialize(params)
      @params = params
    end

    def user
      @user ||= authenticate
    end

    def authenticated?
      user.present?
    end

    private
    def authenticate
      @user = User.find_by_email(@params[:email])&.authenticate(@params[:password])
    end
  end
end
