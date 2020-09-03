class ComercioSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :domicilio, :telefono, :celular, :web, :facebook, :instagram, :url_foto,
  :twitter, :latitud, :longitud, :email, :descripcion, :entrega, :rubro_id, :provincia_id, :departamento_id, :localidad_id
  has_one :provincia
  has_one :departamento
  has_one :localidad
  has_one :rubro
  #has_many :horarios, each_serializer: HorarioSerializer
  # has_many :horarios do
  #   object.horarios.order(:dia).group_by(&:dia).map do |k,v|
  #     [ 
  #       case k
  #       when 1
  #           'Lunes'
  #       when 2
  #           'Martes'
  #       when 3
  #          'Miercoles'
  #         when 4
  #           'Jueves'
  #         when 5
  #           'Viernes'
  #         when 6
  #           'Sabado'
  #         when 7
  #           'Domingo'
  #       end ,
  #        v.map{|h| HorarioSerializer.new(h)} ]
  #   end.to_h
  # end 

  has_many :horarios do
    object.horarios.order(:dia)
  end
  #has_one :usuario
end
