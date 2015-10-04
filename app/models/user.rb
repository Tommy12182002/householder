class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	#名前のバリデーション
	validates :name, presence: true

	#Journalテーブルとのリレーション
	has_many :journals, dependent: :destroy
	has_many :categories, dependent: :destroy
end
