class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :slug, :text, :resource_type
  validates_uniqueness_of :slug
  belongs_to :category
end