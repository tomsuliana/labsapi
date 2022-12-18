class XmlController < ApplicationController
  before_action :check, only: :index
  before_action :parse_params, only: :index

  def index 
    @palindromes = palindroms(@digit)
    data = if @palindromes.nil?
      {message: "Неверные параметры запроса #{@digit}"}
    else 
      @palindromes.map{ |elem| {elem: elem, binary: (elem*elem).to_s}}
    end

    respond_to do |format|
      format.xml{render xml: data.to_xml}
      format.rss{render xml: data.to_xml}
    end

  end

  def palindrom(aaa)
    stra = aaa.to_s
    stra.reverse == stra
  end

  def palindroms(num)
    mas = []
    num.to_i.times do |iter|
      mas.push(iter) if palindrom(iter) && palindrom(iter * iter)
    end
    mas
  end

  protected

  def parse_params
    @digit = params[:digit]
  end

  def check
    return redirect_to root_path unless check_nil(params[:digit]).nil?

    return redirect_to root_path unless check_word.nil?
  end

  def check_nil(num)
    flash[:error] = 'Incorrect input: empty params' if num.nil? || num.empty?
  end

  def check_word
    flash[:error] = 'Error: Input negative' if params[:digit].match(/^-\d+$/)

    flash[:error] = 'Error: Input words' if params[:digit].match(/\D+/)
  end
end
