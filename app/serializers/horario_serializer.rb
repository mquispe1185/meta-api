class HorarioSerializer < ActiveModel::Serializer
  attributes :id, :dia, :desde, :hasta
 # has_one :comercio

  attribute :desde do 
  	object.desde.strftime "%H:%M" 
  end
  attribute :hasta do 
  	object.hasta.strftime "%H:%M" 
  end

  attribute :dia_nombre do 
    case object.dia
    when 1
        'Lunes'
    when 2
        'Martes'
      when 3
      'Miercoles'
      when 4
      'Jueves'
      when 5
       'Viernes'
      when 6
       'Sabado'
      when 7
       'Domingo'
      end
  end
end
