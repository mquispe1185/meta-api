class UsuarioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :telefono, :celular, :provincia_id, :departamento_id, :localidad_id,:domicilio,:email,:habilitado,:en_espera
  has_one :provincia

  attribute :acceso_promos do 
  	object.comercios.where(tipo_servicio_id: [3,4]).count > 0 ? true : false
  end
end
