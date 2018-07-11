class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def games
    Game.where(white_player_id: self).or(Game.where(black_player_id: self))
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |player|
      player.email = auth.info.email
      player.password = Devise.friendly_token[0, 20]
      player.playername = auth.info.name
    end
  end

  has_many :games, :dependent => :delete_all
  has_many :pieces, :dependent => :delete_all
end
