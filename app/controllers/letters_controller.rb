class LettersController < ApplicationController

  def index
    if params[:start_date]||params[:end_date]||params[:files_count]||params[:is_read]
      @letters= filtered_letters
    else
      @letters= Letter.all
    end
  end

  def journal
    @journal = {}
    @accounts= Account.all
    @accounts.each do |account|
      @journal[account] = Hash.new(0)
      account.letters.each do |letter|
        @journal[account][letter.timestamp.strftime("%Y-%m-%d %H:%M:%S")]+=1
      end
    end
  end

  def filtered_letters
    @filter_hash ={}
    @filter_str = ''

    set_filter_is_read( 'is_read=', 'is_read')
    set_filter( 'date>=', 'start_date')
    set_filter( 'date<=', 'end_date')
    set_filter( 'files_count=', 'files_count')

    if @filter_str.blank?
      Letter.all
    else
       Letter.where(@filter_str, @filter_hash)
    end
  end

  private

    def set_filter(comparison, param_name)
      unless params[param_name].blank?
        @filter_hash[param_name.to_sym]= params[param_name]
        @filter_str<<" And " unless @filter_str.blank?
        @filter_str<< comparison<<':'<<param_name
      end
    end


    def set_filter_is_read(comparison, param_name)
      unless params[param_name] =="all"
        @filter_str<<" And " unless @filter_str.blank?
        @filter_str<< comparison<<params[param_name]
      end
    end




end
