module JournalsHelper

  # 家計簿画面の日付を表示する
  def display_journal_header
    if @year.present? and @month.present?
      "#{@year}/#{@month} の家計簿"
    else
      if @year.present?
        "#{@year}年の家計簿"
      else
        "すべての家計簿"
      end
    end
  end

  def next_link
    if @year.present? and @month.present?
      tmp = Date.new(@year.to_i, @month.to_i, 1) >> 1
      link_to "次の月へ",
        user_journal_month_path(@user, tmp.year, tmp.month), 
        :method => :get,
        :class=> "label label-info pjax"
    else
			if @year.present?
				tmp = Date.new(@year.to_i, 1 , 1) >> 12 
				link_to "次の年へ",
					user_journal_year_path(@user, tmp.year), 
					:method => :get,
					:class=> "label label-info pjax"
			end
    end
  end

  def prev_link
    if @year.present? and @month.present?
      tmp = Date.new(@year.to_i, @month.to_i, 1) << 1
      link_to "前の月へ",
        user_journal_month_path(@user, tmp.year, tmp.month), 
        :method => :get,
        :class=> "label label-info pjax"
    else
			if @year.present?
				tmp = Date.new(@year.to_i, 1 , 1) << 12 
				link_to "前の年へ",
					user_journal_year_path(@user, tmp.year), 
					:method => :get,
					:class=> "label label-info pjax"
			end
    end
  end

end
