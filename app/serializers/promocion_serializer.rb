class PromocionSerializer < ActiveModel::Serializer
  attributes :id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, :prioridad, :estado,:habilitado,
  has_one :comercio
  has_one :usuario
end
