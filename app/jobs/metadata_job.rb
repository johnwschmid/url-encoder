class MetadataJob < ApplicationJob
  def perform(id)
    link = Link.find(id)
    link.update Metadata.retrieve_data(link.url).attributes
    link.broadcast_replace_to link
  end
end