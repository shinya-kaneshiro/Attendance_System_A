class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  attr_accessor :remember_token
  has_secure_password
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンをダイジェストに変換する
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ハッシュ化したトークンをDBに保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # remember_digestをnilにする
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # CSVファイルを読み込む、importメソッド。
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["id"]) || new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
    end
  end

  # importメソッドで更新を許可するカラムを定義
  def self.updatable_attributes
    [
      "name", "email", "affiliation","employee_number","uid",
      "basic_work_time", "designated_work_start_time", "designated_work_end_time",
      "superior", "admin", "password", "password_confirmation"
    ]
  end
end
