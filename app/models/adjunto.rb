class Adjunto < ActiveRecord::Base
  belongs_to :medio
  attr_accessible :autor, :fecha, :sumario, :titulo
end
