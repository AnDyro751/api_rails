class ApplicationController < ActionController::Base
  before_action :set_jbuilder_default
  protected
    def authenticate_owner(owner)
      if owner != @current_user
        render json:{errors:"No tienes autorizada esta accion ! D:" }, status: :unauthorized
        return false
      end
      true
    end

    def authenticate
      token_str = params[:token]
      token = Token.find_by(token: token_str)
      if token.nil? || !token.is_valid?
        render json:{errors: "Tu token es invalido" , status: :unauthorized}
      else
        @current_user = token.user
      end
    end

    def set_jbuilder_default
      @errors = []
    end

end
