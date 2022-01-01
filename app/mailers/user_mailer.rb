class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    @url  = 'https://www.germanysmash.de/tournaments'
    mail(to: @user.email, subject: 'Welcome to the GermanySmash Tournament Manager')
  end

end
