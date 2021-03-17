class ComercioShortSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio,:url_foto,:descripcion
end
