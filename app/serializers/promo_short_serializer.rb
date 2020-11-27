class PromoShortSerializer < ActiveModel::Serializer
  attributes :id, :desde, :hasta, :titulo, :descripcion, :prioridad,:comercio_id,:url
  #has_one :comercio
end
