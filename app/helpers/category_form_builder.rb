class CategoryFormBuilder < ActionView::Helpers::Frombuilder
	def handle_edit
	
		if Journal.exists?(:user_id => user_id, :category => category)
			f.text_field :category, :class => 'form-control', :disabled => true
		else
			binding.pry
			f.text_field :category, :class => 'form-control'
		end
	end
end
