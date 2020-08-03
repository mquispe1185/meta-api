class LocalidadSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :activo
  has_one :departamento
  has_one :provincia
end
