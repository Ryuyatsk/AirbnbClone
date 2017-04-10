class UsersController < ApplicationController
  def show #show.html.erbを表示するアクション
  	@user = User.find(params[:id]) #Userモデルから、Userを探してきた。
  end
end
