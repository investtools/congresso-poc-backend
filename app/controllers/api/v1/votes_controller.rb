class Api::V1::VotesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @vote = Vote.new(permitted_vote_params)
    if @vote.save
      render json: {
        id: @vote.id,
        law_project: @vote.law_project,
        vote_choice: @vote.vote_choice,
        comment: @vote.comment,
        address: @vote.address,
        signed_message: @vote.signed_message
      }
    else
      render json: {status: "failure", msg: @vote.errors.full_messages}, status: 422
    end
  end

  def permitted_vote_params
    params[:vote].permit(:law_project_id, :vote_choice, :comment, :address, :signed_message)
  end
end