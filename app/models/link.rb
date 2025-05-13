class Link < ApplicationRecord
  belongs_to :user, optional: true
  has_many :views, dependent: :destroy

  validates :url, presence: true

  scope :recent_first, -> {order(created_at: :desc)}

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform_now to_param
  end

  def self.find(id)
    super Base62.decode(id)
  end

  def to_param
    Base62.encode(id)
  end

  def domain
    URI(url).host
  end

  def favicon_image_tag(url)
    "https://www.google.com/s2/favicons?domain=#{url}"
  end
end
