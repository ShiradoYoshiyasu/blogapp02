class Article < ActiveRecord::Base

  belongs_to :category
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :title, presence: { message: "タイトルを入力してください"},
            length: { maximum: 30, message:"本文は30字以内にしてください" },
            uniqueness: { scope: [:user_id], message:"過去に同一タイトルの投稿があります"}
  validates :sentence, presence: { message: "本文を入力してください"},
            length: { minimum: 10, message: "本文は10文字以上にしてください",
                      maximum: 1000, message:"本文は1000字以内にしてください" }
  validates :category_id, presence: { message: "カテゴリーを選択してください"}

  scope :search_by_category, -> (category){where('category_id = ?', category) if category.present?}
  scope :search_by_string, -> (string){where('title LIKE :string or sentence LIKE :string', string: "%#{string}%" ) if string.present?}
  scope :search_by_user, -> (user, self_id){where('user_id = ?', self_id) if user == "y"}

end
