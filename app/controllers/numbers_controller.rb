class NumbersController < ApplicationController

  def index
    @numbers = Number.all.order(id: "desc")
  end

  def new
    @number = Number.new
    @number.analyzes.build
    @number.analyzes.build
    @number.analyzes.build
  end

  def create
    @number = Number.new(number_params)
    if @number.save
      GetDomainDetailJob.perform_later(@number.id)
      redirect_to number_path(@number), notice: "成功增加，正在全力解析，请刷新以更新数据！"
    else
      render :new
    end
  end

  def show
    @number = Number.find(params[:id])
  end

  def destroy
    @number = Number.find(params[:id])
    if @number.destroy
      redirect_to numbers_path, alert: "已删除！"
    end
  end

  private
  def number_params
    params.require(:number).permit(:analyzes_attributes => [:id, :domain, :remarks])
  end
end
