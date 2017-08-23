class AnalyzesController < ApplicationController

  def new
    @analyze = Analyze.new
  end

  def create
    @analyze = Analyze.new(analyze_params)
    if @analyze.save
      redirect_to analyze_path(@analyze), notice: "create success"
    else
      render :new
    end
  end

  private
  def analyze_params
    params.require(:analyze).permit(:domain, :remarks, :id)
  end
end
