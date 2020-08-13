class UsuarioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :telefono, :celular, :provincia_id, :departamento_id, :localidad_id,:domicilio,:email,:habilitado
  has_one :provincia
end
