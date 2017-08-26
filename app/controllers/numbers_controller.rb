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

  def liang
    require 'nokogiri'
    require 'open-uri'
    url = "http://www.74808.com/jcs/yzxz.htm"
    html=open(url).read
    charset=Nokogiri::HTML(html).meta_encoding#！有些网页没有定义charset则不适用
    html.force_encoding(charset)
    html.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
    doc = Nokogiri::HTML.parse html
    table = doc.css("table")
    rr = table.css("table").search("tr").to_a
    ex = rr.to_a.delete_if {|i| !i.to_s.scan(/\d\d\d期/).first.present? }
    @html = ex.last.to_html.html_safe
    binding.pry

  end

  private
  def number_params
    params.require(:number).permit(:analyzes_attributes => [:id, :domain, :remarks])
  end
end
