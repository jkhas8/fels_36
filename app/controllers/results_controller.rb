class ResultsController < ApplicationController
  def index
    @lession = Lession.find params[:lession_id]
  end
end
