class ReferenciaSerializer < ActiveModel::Serializer
  attributes :id, :cuerpo, :puntaje
  has_one :usuario, serializer: UsuarioShortSerializer
end
