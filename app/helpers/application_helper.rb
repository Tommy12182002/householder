module ApplicationHelper
  # ログイン中の場合はログアウトを、ログインしていない場合はログインリンクを表示する
  def show_login_header
    content_str = ''
		today = Date.today
    if user_signed_in? then
      content_str << "<li class='active'>#{link_to 'プロフィール変更', edit_user_registration_path}</li>"
			content_str << "<li class='active'>#{link_to "今月の家計簿", user_journal_month_path(current_user, today.year, today.month)}</li>"
			content_str << "<li class='active'>#{link_to "カテゴリ", user_categories_path(current_user)}</li>"
    else
      content_str << "<li class='active'>#{link_to '新規登録', new_user_registration_path }</li>"
      content_str << "<li class='active'>#{link_to 'ログイン', new_user_session_path}</li>"
    end
    content_str.html_safe
  end

	def show_user_name
		content_str = ''
		if user_signed_in? then
      content_str << "<li class='active'>#{link_to current_user.name, edit_user_registration_path}</li>"
      content_str << "<li class='active'>#{link_to 'ログアウト', destroy_user_session_path, method: :delete}</li>"
		end
		content_str.html_safe
	end


end
