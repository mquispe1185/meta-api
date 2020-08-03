class DepartamentoSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :activo
  has_one :provincia
end
