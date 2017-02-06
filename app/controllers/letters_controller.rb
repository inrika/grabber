class LettersController < ApplicationController
    include Filter

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

  private

    def filtered_letters
      @filter_hash ={}
      @filter_str = ''

      set_filter_is_read
      set_filter_start_date
      set_filter_end_date
      set_filter_files_count

      if @filter_str.blank?
        Letter.all
      else
         Letter.where(@filter_str, @filter_hash)
      end
   end

end
