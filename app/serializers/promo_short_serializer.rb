class PromoShortSerializer < ActiveModel::Serializer
  attributes :id, :desde, :hasta, :titulo, :descripcion, :prioridad
  #has_one :comercio
end
