class Adjunto < ActiveRecord::Base
  attr_accessible :autor, :fecha, :sumario, :titulo, :medio_id, :url

  belongs_to :medio
  accepts_nested_attributes_for :medio

  validates_presence_of :medio_id, :titulo, :url
  validates :url, :uniqueness => true

  def descripcion
  	nota = ""
  	nota += fecha if fecha
  	nota += "#{nota} #{autor}" if autor
  	nota = "<b>#{nota}</b>: "
  	nota += " <em>#{titulo}</em>"
  end

end
