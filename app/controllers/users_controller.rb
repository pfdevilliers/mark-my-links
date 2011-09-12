class UsersController < ApplicationController
   before_filter :authenticate_user!
   def show
        @user = User.find(params[:id])
        @topics = Topic.find_all_by_user_id(@user.id)
        @posts = Post.find_all_by_user_id(@user.id)

        respond_to do |format|
            format.html
            format.xml{ render :xml => @user }
        end
     end
end
