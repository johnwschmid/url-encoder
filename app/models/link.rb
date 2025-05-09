class Link < ApplicationRecord
  has_many :views, dependent: :destroy

  validates :url, presence: true

  scope :recent_first, -> {order(created_at: :desc)}

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform to_param
  end

  def to_param
    Base62.encode(id)
  end

  def domain
    URI(url).host
  end

  def self.find(id)
    super Base62.decode(id)
  end
end
