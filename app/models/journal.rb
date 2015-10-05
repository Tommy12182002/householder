class Journal < ActiveRecord::Base
	belongs_to :user

    # ユーザに紐づく行を取得する
    def self.get_journals(user, y=nil, m=nil, w=nil)
      # 年・月・週まで指定されている場合
      if y.present? and m.present? and w.present? then
        return user.journals.where(year: y, month: m, week: w).order(:document_date)
      end
      
      # 年・月まで指定されている場合
      if y.present? and m.present? then
        return user.journals.where(year: y, month: m).order(:document_date)
      end
      
      # 年のみ指定されている場合
      if y.present? then
        return user.journals.where(year: y).order(:document_date)
      end

      user.journals.order(:document_date)
    end

    # 新しいレコードの作成
    def self.generate_new_journal(user, y=nil, m=nil)
      today = Date.today
      current_year = today.year

      journal = user.journals.build

      # パラメータの月が現在日付の月と同じなら、現在日付を日付に、
      # 異なる場合は、パラメータの月の一日を日付に設定する。
			journal.document_date = today

			if y.present? and m.present?
				if y.to_i != today.year or m.to_i != today.month
					journal.document_date = Date::new(y.to_i , m.to_i, 1)
				end
			else
				if y.present?
					journal.document_date = Date::new(y.to_i , 1, 1)
				end
			end

      journal.month = journal.document_date.month.to_i
      journal.year = journal.document_date.year.to_i

      journal.remarks = '新規登録'
      journal.category= '任意のカテゴリ'
      journal.amount = 0 
      journal.save
      journal
    end
    
    # カテゴリごとに集計する
    def self.summary_with_category(jours)
			jours.reorder(:category)	
      jours.group(:category).sum(:amount)
    end

    # カテゴリ・日付が同じレコードをマージする 
    def self.merge_by_category_date(user, jours, y=nil, m=nil)

      if y.present? and m.present? then
        data = jours.where(:year => y, :month => m).group(:category, :document_date).sum(:amount)
      else
        if y.present? then
          data = jours.where(:year => y).group(:category, :document_date).sum(:amount)
        else
          data = jours.group(:category, :document_date).sum(:amount)
        end
      end

      Journal.transaction do
        data.each do |key, amount|
          # マージ対象のレコード削除
          Journal.destroy_all(:user_id => user.id,
                              :document_date => key[1],
                              :category => key[0])

          # 削除後、マージしたレコードをInsertする
          y = key[1].to_date.year
          m = key[1].to_date.month

          journal = user.journals.build
          journal.document_date = key[1]
          journal.category = key[0]
          journal.amount = amount
          journal.month = m 
          journal.year = y
          journal.remarks = 'まとめたレコード'
          journal.save!
        end
      end
    end
end
