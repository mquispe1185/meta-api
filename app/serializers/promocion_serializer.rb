class PromocionSerializer < ActiveModel::Serializer
  attributes :id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, :prioridad, :estado,:habilitado, :formapago_id
  has_one :comercio
  has_one :usuario
  has_one :formapago
end
