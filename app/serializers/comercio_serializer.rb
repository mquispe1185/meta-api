# usado en index para admin

class ComercioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, :instagram, :url_foto,:tags,:habilitado, :estado,
  :facebook_id, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id,
  :visitas, :visitas_face, :visitas_ig, :visitas_web, :visitas_wsp,
  :envio,:es_fanpage, :created_at, :url_video
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  has_one :usuario
  has_one :tipo_servicio
  has_many :horarios
end
