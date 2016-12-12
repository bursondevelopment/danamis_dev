class Adjunto < ActiveRecord::Base
  belongs_to :medio
  attr_accessible :autor, :fecha, :sumario, :titulo, :medio_id, :url

  validates_presence_of :medio_id, :titulo, :url
  validates :url, :uniqueness => true

end
