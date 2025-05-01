class Link < ApplicationRecord
  has_many :views
  
  validates :url, presence: true
  scope :recent_first, -> {order(created_at: :desc)}

  def to_param
    Base62.encode(id)
  end

  def self.find(id)
    super Base62.decode(id)
  end
end
