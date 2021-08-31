#Utilizado para MIS COMERCIOS vista del Comerciante.

class MisComerciosSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, :instagram, :url_foto,:tags,:habilitado, :estado,
  :facebook_id, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id,
  :envio,:es_fanpage, :es_gratuito, :es_basico, :es_estandar, :es_premium
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  has_one :usuario
  has_one :tipo_servicio
  has_many :horarios 

  attribute :plan_hasta do 
  	object.comercioplanes.vigente.last&.hasta
  end

  attribute :plan_pendiente do 
    if object.estado == 'cambio_pendiente'
      object.comercioplanes.last&.tipo_servicio&.nombre
    end
  end
end
