class Category < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  validates :name, presence: { message: "カテゴリー名を入力してください"}
end
