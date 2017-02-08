class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.find_or_initialize_by(email: account_params[:email])
    @account.assign_attributes(account_params)
    if @account.save
      gmail = Gmail.connect(@account.email, @account.password)
      if gmail.logged_in?
        @account.create_letters(gmail,params[:startDate], params[:endDate])
        redirect_to letters_path
      else
        redirect_to new_account_path, notice: 'нет соединения'
      end
    else
      redirect_to new_account_path, notice: 'не записалось'
    end
  end

  private
  def account_params
    params.require(:account).permit(:email, :password)
  end

end
