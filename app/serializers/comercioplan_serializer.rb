class ComercioplanSerializer < ActiveModel::Serializer
  attributes :id, :estado, :desde, :hasta, :importe
  has_one :comercio
  has_one :tipo_servicio
  has_one :formapago
  has_one :usuario
end
