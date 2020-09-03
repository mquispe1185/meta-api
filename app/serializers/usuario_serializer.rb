class UsuarioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :telefono, :celular, :provincia_id, :departamento_id, :localidad_id,:domicilio,:email,:habilitado,:en_espera
  has_one :provincia
end
