class Comercio < ApplicationRecord
  belongs_to :provincia
  belongs_to :departamento
  belongs_to :localidad
  belongs_to :usuario
  belongs_to :rubro
  has_many :horarios, dependent: :destroy

  has_one_attached :foto, dependent: :destroy

  def self.search(search)
    if search
      where('nombre ILIKE :search OR tags ILIKE :search', search: "%#{search}%")
    else
      all
    end
  end

end
