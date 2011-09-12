class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

    
  def after_sign_in_path_for(resource_or_scope)
    return_path = params[:next]
    if return_path =~ /topics\/\d\/posts/
        return_path = return_path[0, return_path.length - 5] + "?" +
        "post_link=" + params[:post_link]
    else
        super
    end
  end
end
