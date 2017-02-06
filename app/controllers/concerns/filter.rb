module Filter
  extend ActiveSupport::Concern
  private

  def set_filter_is_read
   unless params[:is_read]=="all"
     @filter_hash[:is_read] = params[:is_read]
     @filter_str<<" And " unless @filter_str.blank?
     @filter_str<<"is_read= true" if params[:is_read]=="read"
     @filter_str<<"is_read= false" if params[:is_read]=="unread"
   end
  end

  def set_filter_start_date
    unless params[:start_date].blank?
      @filter_hash[:start_date]= params[:start_date]
      @filter_str<<" And " unless @filter_str.blank?
      @filter_str<<"date>= :start_date"
    end
  end

  def set_filter_end_date
    unless params[:end_date].blank?
      @filter_hash[:end_date]= params[:end_date]
      @filter_str<<" And " unless @filter_str.blank?
      @filter_str<<"date<= :end_date"
    end
  end

  def set_filter_files_count
    unless params[:files_count].blank?
      @filter_hash[:files_count]= params[:files_count]
      @filter_str<<" And " unless @filter_str.blank?
      @filter_str<<"files_count= :files_count"
    end
  end

end
