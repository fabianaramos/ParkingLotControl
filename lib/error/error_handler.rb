module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActionController::ParameterMissing do |e|
          respond(:bad_request, 400, I18n.t('activerecord.errors.messages.parameter_missing', attribute: e.param))
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(:unprocessable_entity, 422, e.to_s)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:not_found, 404,
                  I18n.t('activerecord.errors.messages.record_not_found', model: e.model.constantize.model_name.human))
        end
      end
    end

    private

    def respond(_error, _status, _message)
      json = Helpers::Render.json(_error, _status, _message)
      render json: json, status: _status
    end
  end
end
