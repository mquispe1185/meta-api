class Comercio < ApplicationRecord
  belongs_to :provincia
  belongs_to :departamento
  belongs_to :localidad
  belongs_to :usuario
  belongs_to :rubro
  belongs_to :tipo_servicio
  has_many :horarios, dependent: :destroy

  has_one_attached :foto, dependent: :destroy

  before_create :servicio
   # ESTADOS DE COMERCIO
   DEFAULT = 0
   CONCAMBIOPENDIENTE = 1

  def self.search(search)
    if search
      where('nombre ILIKE :search OR tags ILIKE :search', search: "%#{search}%")
    else
      all
    end
  end

  def self.searchrubro(search)
    if search
      joins(:rubro).where(rubros: {descripcion: search})
    else
      all
    end
  end
  def servicio
    self.tipo_servicio_id = 1
  end
end
