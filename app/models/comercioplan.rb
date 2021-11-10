class Comercioplan < ApplicationRecord
  belongs_to :comercio
  belongs_to :tipo_servicio
  belongs_to :servicio_anterior, :class_name => 'TipoServicio', optional: true
  belongs_to :formapago
  belongs_to :usuario
  enum estado: %i[pendiente aprobado vencido rechazado]
   # ESTADOS DE PLANES
   PENDIENTE = 0
   APROBADO = 1
   VENCIDO = 2
   RECHAZADO = 3

   before_create :gen_code
   before_create :set_duracion, if: :es_gratuito?
   scope :activos, -> { where(activo: true) }
   scope :inactivos, -> { where(activo: false) }
   scope :vigente, -> { where(estado: :aprobado)}
   
  private
  def gen_code
    self.codigo = SecureRandom.urlsafe_base64(4).downcase
  end
  
  def set_duracion
    self.desde = Date.today
    self.hasta = meses.months.from_now
  end

  def es_gratuito?
    tipo_servicio_id == TipoServicio::GRATUITO
  end
end
