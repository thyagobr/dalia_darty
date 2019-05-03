require 'generate_survey'

class SurveysController < ApplicationController
  def create
    result = GenerateSurvey.new(survey_params).generate!
    if result.success?
      render json: { }, status: 201
    else
      render json: { errors: "yeah, errors" }, status: 400
    end
  end

  private

  def survey_params
    params.permit(:title, :description, :author_source)
  end
end
