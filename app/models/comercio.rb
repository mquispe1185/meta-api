class Comercio < ApplicationRecord
  belongs_to :provincia
  belongs_to :departamento
  belongs_to :localidad
  belongs_to :usuario
  belongs_to :rubro
  belongs_to :tipo_servicio
  has_many :horarios, -> { order(:dia, :desde) }, dependent: :destroy
  has_many :promociones
  has_many :comercioplanes, dependent: :destroy
  has_one_attached :foto, dependent: :destroy

  before_create :servicio
  after_create :set_comercioplan
  # ESTADOS DE PLAN ACTUAL DE COMERCIO
  enum estado: %i[default cambio_pendiente]

  scope :activos, -> { where(activo: true) }
  scope :inactivos, -> { where(activo: false) }

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
                        estado: :pendiente, desde: Time.now, hasta: 30.days.from_now,
                        importe: 0, usuario: usuario, meses: 1, pagado: true)
  end

  def direccion_string
    "#{domicilio} - #{localidad.nombre} - #{provincia.nombre}"
  end

  def es_gratuito
    tipo_servicio_id == 1 ? true : false
  end

  def es_economico
    tipo_servicio_id == 2 ? true : false
  end

  def es_estandar
    tipo_servicio_id == 3 ? true : false
  end

  def es_premium
    tipo_servicio_id == 4 ? true : false
  end

  def active_links
    es_estandar || es_premium
  end

  def show_economico
    es_economico || es_estandar || es_premium
  end

  def show_estandar
    es_estandar || es_premium
  end
end
