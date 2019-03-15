class SessionsController < ApplicationController
  before_action :twitter_params, only: [:twitter]

  def resisteration_done
    user = User.find(request.url.split('/').last.to_i)
    if user.profile.nil?
      User.remove_same_email(user)
      profile = user.build_profile
      if profile.save
        log_in user
        redirect_to root_path, notice: '登録が完了しました'
      else
        redirect_to root_path, alert: '登録に失敗しました'
      end
    else
      redirect_to root_path, alert: '既に登録されています'
    end
  end

  def new
    if params[:login].nil?
      flash.now[:notice] = 'ログインしてください'
    end
  end

  def create
    user = User.find_by(session_params)
    if user && user.authenticate(params[:session][:password])
      if user.profile
        log_in user
        redirect_to root_path, notice: 'ログインしました'
      else
        flash.now[:alert] = '登録が完了していません'
        render :new
      end
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new
    end
  end

  def twitter
    if User.find_by(email: @email)
      user = User.find_by(email: @email)
    else
      user = User.create(name: @name, email: @email, password: @password, password_confirmation: @password_confirmation)
      profile = user.build_profile
      profile.remote_image_url = @image
      profile.save
    end

    if log_in user
      redirect_to root_path, notice: 'ログインしました'
    else
      redirect_to root_path, alert: 'ログインに失敗しました'
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

  def twitter_params
    informations = request.env['omniauth.auth'][:info]
    @image = informations[:image]
    @name = informations[:nickname]
    @email = informations[:email]
    @password = "1234qwer"
    @password_confirmation = "1234qwer"
  end
end
