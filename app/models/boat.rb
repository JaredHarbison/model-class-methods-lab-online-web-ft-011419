class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.first(5)
  end

  def self.dinghy
    where("length < '20'")
  end

  def self.ship
    where("length > '20'")
  end

  def self.last_three_alphabetically
    self.all.order(name: :desc).first(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where({classifications: {name: "Sailboat"}})
  end

  def self.not_sailboats
    joins(:classifications).where.not({classifications: {name: "Sailboat"}})
  end

  def self.with_three_classifications
      joins(:classifications).group(:boat_id).having("COUNT(*) = 3")
  end

  def self.longest
    self.order(:length).last
  end

end 
