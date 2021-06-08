# Utilizado para Busquedas de visitante.

class ComercioShortSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio,:url_foto,:descripcion
end
