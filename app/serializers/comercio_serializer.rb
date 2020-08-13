class ComercioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :horario_desde, :horario_hasta, :facebook, :instagram, 
  :twitter, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  #has_one :usuario
end
