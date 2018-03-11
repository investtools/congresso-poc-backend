class Api::V1::LawProjectsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: LawProject.all
  end

end