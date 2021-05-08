class Comercio < ApplicationRecord
  belongs_to :provincia
  belongs_to :departamento
  belongs_to :localidad
  belongs_to :usuario
  belongs_to :rubro
  belongs_to :tipo_servicio
  has_many :horarios, dependent: :destroy
  has_many :promociones
  has_one_attached :foto, dependent: :destroy

  before_create :servicio
  after_create :set_comercioplan
   # ESTADOS DE COMERCIO
   DEFAULT = 0
   CONCAMBIOPENDIENTE = 1

  def self.search(search)
    if search
      where('nombre ILIKE :search OR tags ILIKE :search', search: "%#{search}%").where(activo: true, habilitado: true)
    else
      all
    end
  end

  def self.searchrubro(search)
    if search
      joins(:rubro).where(rubros: {descripcion: search},activo: true, habilitado: true)
    else
      all
    end
  end
  
  def servicio
    self.tipo_servicio_id = TipoServicio::ESTANDAR
  end

  def set_comercioplan
    Comercioplan.create(comercio: self, tipo_servicio: tipo_servicio, formapago: Formapago.first,
      estado: :aprobado, desde: Time.now, hasta: 30.days.from_now,
      importe: 0, usuario: usuario, meses: 1, pagado: true)
  end
end
