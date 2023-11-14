class TurboDeviseController < ApplicationController
    class Responder < ActionController::Responder
      def to_turbo_stream
        controller.render(options.merge(formats: :html))
      rescue ActionView::MissingTemplate => error
        if get?
          raise error
        elsif has_errors? && default_action
          render rendering_options.merge(formats: :html, status: :unprocessable_entity)
        else
          redirect_to navigation_location
        end
      end
    end
  
    self.responder = Responder
    respond_to :html, :turbo_stream
  end

  # Devise isn’t (yet) prepared for that and it won’t be able to display flash messages
  # — which it relies heavily on — by default. We need to alter the code that Devise 
  # generates for us to deal with Turbo.