#Usado para vista completa de Comercio para el VISITANTE.

class ComercioVisitanteSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, 
  :instagram, :url_foto, :facebook_id, :latitud, :longitud, :email, :descripcion, 
  :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id, :envio
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  has_one :usuario
  has_many :horarios
end
