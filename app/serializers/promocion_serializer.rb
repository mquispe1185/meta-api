class PromocionSerializer < ActiveModel::Serializer
  attributes :id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, :prioridad, 
  :estado,:habilitado, :url, :formapago_id, :importe, :costo_diario
  has_one :comercio
  has_one :usuario
  has_one :formapago
end

# :formapago_id,:importe, :costo_diario,
# has_one :formapago