class Api::V1::AuthorizationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @authorization = Authorization.new(permitted_authorization_params)
    if @authorization.save
      render json: {
        id: @authorization.id,
        cpf: @authorization.cpf,
        address: @authorization.address
      }
    else
      render json: {status: "failure", msg: @authorization.errors.full_messages}, status: 422
    end
  end

  def destroy
    @authorization = Authorization.find_by(address: params[:id])
    if @authorization.present?
      @authorization.destroy
      render json: {status: "ok", msg: "Chave revogada com sucesso"}, status: 200
    else
      render json: {status: "error", msg: "Chave não encontrada"}, status: 422
    end
  end

  def permitted_authorization_params
    params[:authorization].permit(:cpf, :address)
  end
end