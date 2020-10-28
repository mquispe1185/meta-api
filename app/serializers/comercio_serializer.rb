class ComercioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, :instagram, :url_foto,:tags,:habilitado, :tipo_servicio,
  :twitter, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id,:envio
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  has_one :usuario


  has_many :horarios do
    object.horarios.order(:dia)
  end


  attribute :tipo_servicio_descripcion do 
    case object.tipo_servicio
    when 0
      'GRATUITO'
    when 1
        'ECONOMICO'
    when 2
        'ESTANDAR'
      when 3
      'PREMIUM'
      end
  end
end
