class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_500

  private

  def return_404
    render status: 404, json: { "error": "Objeto nao encontrado" }
  end

  def return_500
    render status: 500, json: { "error": "Nao foi possivel conectar ao banco de dados" }
  end
end
