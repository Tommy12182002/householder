class JournalsController < ApplicationController
  before_action :get_params
  before_action :set_current_journals, :only => [:index, :year, :month, :merge]

  # 新規投稿	
  def new
    @user = User.find(@user_id)
    
    # 新しいレコード作成
    @journal = Journal.generate_new_journal(@user, @year, @month)
    # 一覧画面タイトル再描画のための月の設定
    redirect_to journal_list(@user_id, @year, @month)
  end

  def index 
    #グラフ用のデータを取得
    @graph_data = Journal.summary_with_category(@journals) 
		@sum = @journals.sum(:amount).to_s(:delimited)
  end

  def year 
    #グラフ用のデータを取得
    @graph_data = Journal.summary_with_category(@journals) 
		@sum = @journals.sum(:amount).to_s(:delimited)
  end
  
  def month 
    #グラフ用のデータを取得
    @graph_data = Journal.summary_with_category(@journals) 
		@sum = @journals.sum(:amount).to_s(:delimited)
  end

  # 更新処理
  def update
    # パラメータ取得
    @journals = journals_params.map do |id, journal_param|
      if journal_param[:update] == "true"
        set_current_journal(id)
        temp_year = journal_param[:document_date].to_date.year
        temp_mth = journal_param[:document_date].to_date.month
        @journal.update_attributes(
          :year => temp_year,
          :month => temp_mth,
          :document_date => journal_param[:document_date],
          :remarks => journal_param[:remarks],
          :category=> journal_param[:category],
          :amount=> journal_param[:amount]
        )
      end
    end
    # 更新結果をリターン
    redirect_to journal_list(@user_id, @year, @month)
  end

  # 削除処理
  def destroy 
    set_current_journal(params[:id])
    year = @journal.year
    month = @journal.month
    user_id = @journal.user_id

    # Journalを削除し、月の一覧に戻る
    @journal.destroy
    # status303を指定しないとエラーとなる
    redirect_to journal_list(@user_id, year, month), status: 303
  end

  # 同一日付・カテゴリのレコードをマージする。
  def merge
    Journal.merge_by_category_date(@user, @journals, @year, @month)
    # 更新結果をリターン
    redirect_to journal_list(@user.id, @year, @month)
  end

  #現在月の家計簿を取得
  protected
  def set_current_journals
    #月が指定されている場合はその月の家計簿のみ表示する
    @journals = Journal.get_journals(@user, @year, @month, @week) 
  end

  # 更新削除処理のためのJournalを取得する
  protected
  def set_current_journal(id)
    @journal = Journal.find(id)
  end

  #パラメータから対象の月を取得
  protected
  def get_params 
    @year = params[:year] if @year.nil?
    @month = params[:month] if @month.nil?
    @week = params[:week] if @week.nil?
    @user_id = params[:user_id] if @user_id.nil?
    @user = User.find(@user_id) 
  end

	# 年月週のありなしでリダイレクト先のURLを切り替える
	def journal_list(user, y=nil, m=nil, w=nil)
		if y.present? and m.present? and w.present?
			return user_journal_week_path(user, y, m, w)
		end

		if y.present? and m.present?
			return user_journal_month_path(user, y, m)
		end

		if y.present?
			return user_journal_year_path(user, y)
		end
		
		user_journals_path(user)
	end

  # 登録のStrong Parameter
  def journal_params
    params.require(:journal).permit(:amount)
  end

  # 一括更新用のStrong Parameter
  def journals_params
    params.permit(journals: [:document_date, :remarks, :category, :amount, :update])[:journals]
  end
end
