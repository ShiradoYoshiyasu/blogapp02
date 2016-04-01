class Category < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  validates :name, presence: { message: "カテゴリー名を入力してください" },
            uniqueness: { message:"名称が重複しています" },
            length: { maximum: 20, message:"カテゴリー名は20字以内にしてください" }
end
