class CategoryDecorator < Draper::Decorator
  delegate_all

	# 編集可能不可の制御
	def handle_edit(f)
		if Journal.exists?(:user_id => user_id, :category => category)
			f.text_field :category, :class => 'form-control', :disabled => true
		else
			binding.pry
			f.text_field :category, :class => 'form-control'
		end
	end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
