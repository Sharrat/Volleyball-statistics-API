class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    message_name = nil
    case action_name
    when "index"
      message_name = " not loaded"
    when "show"
      message_name = " not loaded"
    when "create"
      message_name = " not saved"
    when "destroy"
      message_name = " not deleted"
    when "update"
      message_name = " not updated"
    end

    render json: {
      status: 'ERROR', message: controller_name + message_name,
      data:{"#{exception.model}": [exception.message]}},status: :not_found
  end
end
