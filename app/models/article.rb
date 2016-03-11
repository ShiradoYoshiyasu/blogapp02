class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :title, presence: { message: "タイトルを入力してください"}
  validates :sentence, presence: { message: "本文を入力してください"}
  validates :category_id, presence: { message: "カテゴリーを選択してください"}
end
