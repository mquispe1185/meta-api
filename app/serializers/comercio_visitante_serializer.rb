#Usado para vista completa de Comercio para el VISITANTE.

class ComercioVisitanteSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :telefono, :celular, :web, :facebook, 
  :instagram, :url_foto, :facebook_id, :latitud, :longitud, :email, :descripcion, 
  :entrega, :envio, :direccion_string, :active_links, :show_economico, :show_estandar

  attribute :descripcion, if: :no_es_gratuito? 
  attribute :url_foto, if: :no_es_gratuito? 
  attribute :latitud, if: :no_es_gratuito?
  attribute :longitud, if: :no_es_gratuito?
  has_many :horarios

  def no_es_gratuito?
    object.es_economico || object.es_estandar || object.es_premium
  end

  attribute :rubro_string do 
  	object.rubro.descripcion 
  end

  attribute :fotos do
    object.fotos.map(&:service_url)
  end
end
