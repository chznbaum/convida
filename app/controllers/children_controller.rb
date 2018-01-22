class ChildrenController < ApplicationController
  before_action :set_account
  before_action :require_account!
  before_action :authenticate_user!

  def index
    @children = @account.children.all
  end

  def show
    @child = @account.children.includes(:attachments).find(params[:id])
  end

  def new
    @child = @account.children.new
  end

  def create
    @child = @account.children.new(child_params)

    if @child.save
      redirect_to children_path, notice: "#{@child.first_name} was successfully added."
    else
      render :new
    end
  end

  private

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end

  def child_params
    params.require(:child).permit(:first_name, :birthdate, :pronoun)
  end
end
