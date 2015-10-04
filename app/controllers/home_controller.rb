class HomeController < ApplicationController
	layout 'home'
  def index
		@graph_data = {"光熱費" => 12000, '食費' => 34000, '住宅費' => 82000, 'レジャー費' => 36000, '仕送り代' => 20000 }
  end
end
