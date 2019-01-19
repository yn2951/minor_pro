class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def twitter
    image = request.env['omniauth.auth'][:info][:image]
    name = request.env['omniauth.auth'][:info][:nickname]
    email = request.env['omniauth.auth'][:info][:email]

    if User.find_by(email: email)
      user = User.find_by(email: email)
    else
      user = User.create(name: name, email: email, password: "1234qwer", password_confirmation: "1234qwer")
      profile = user.build_profile
      profile.remote_image_url = image
      profile.save
    end

    if log_in user
      redirect_to root_path, success: 'ログインしました'
    else
      redirect_to root_path, danger: 'ログインに失敗しました'
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def session_params
    params.require(:session).permit(:email)
  end
end
