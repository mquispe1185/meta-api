class ReferenciaSerializer < ActiveModel::Serializer
  attributes :id, :cuerpo, :puntaje, :activo
  has_one :usuario
end
