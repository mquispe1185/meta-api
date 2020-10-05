class ComercioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, :instagram, :url_foto,:tags,:habilitado,
  :twitter, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id,:envio
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro


  has_many :horarios do
    object.horarios.order(:dia)
  end

end
