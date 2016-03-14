class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :title, presence: { message: "タイトルを入力してください"}
  validates :sentence, presence: { message: "本文を入力してください"}
  validates :category_id, presence: { message: "カテゴリーを選択してください"}
  validates :user_id, presence: { message: "ログインしてください"}

  scope :search_by_category, ->(category){where('category_id = ?', category) if category.present?}
  scope :search_by_string, -> (string){where('title LIKE :string or sentence LIKE :string', string: "%#{string}%" ) if string.present?}
  scope :search_by_user, -> (user, self_id){where('user_id = ?', self_id) if user == "y"}

end
