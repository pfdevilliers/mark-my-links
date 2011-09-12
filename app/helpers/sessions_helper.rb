module SessionsHelper
    
    private
        def store_form_data
            session[:return_to] = request.fullpath
            session[:post_link] = params[:post][:link]
        end
end
