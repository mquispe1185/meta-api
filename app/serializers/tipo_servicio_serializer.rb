class TipoServicioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :descripcion, :importe
end
