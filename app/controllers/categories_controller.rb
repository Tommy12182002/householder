class CategoriesController < ApplicationController
  before_action :category_params, :only => :new
  before_action :get_params 
	# 一覧表示
  def index
    @user = User.find(@user_id)
    @categories = @user.categories.order(:id)
   # @categories = CategoryDecorator.decorate_collection(@user.categories)
  end

  # 新規投稿	
  def create 
    @user = User.find(@user_id)
    @category = @user.categories.create(category_params)
    redirect_to user_categories_path(@user_id)
  end

	def update
    @categories = categories_params.map do |id, category_param|
			set_current_category(id)
			cate = category_param[:category]
			@category.update_attributes(:category=> cate)
    end
    # 更新結果をリターン
    redirect_to user_categories_path(@user_id)
	end

  # 削除処理
  def destroy 
    set_current_category(params[:id])
    @category.destroy
    redirect_to user_categories_path(@user_id)
  end

  protected
  def set_current_category(id)
    @category = Category.find(id)
  end

  #パラメータから対象の月を取得
  protected
  def get_params 
    @user_id = params[:user_id] if @user_id.nil?
  end

  # 登録のStrong Parameter
  def category_params
    params.require(:category).permit(:category)
  end
	
  # 一括更新用のStrong Parameter
  def categories_params
    params.permit(categories: [:category])[:categories]
  end


end
