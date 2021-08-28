class ComercioplanSerializer < ActiveModel::Serializer
  attributes :id, :estado, :desde, :hasta, :importe,:meses,:pagado,:codigo,:created_at
  has_one :comercio
  has_one :tipo_servicio
  has_one :servicio_anterior
  has_one :formapago
  has_one :usuario
end
