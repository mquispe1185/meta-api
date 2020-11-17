class Comercioplan < ApplicationRecord
  belongs_to :comercio
  belongs_to :tipo_servicio
  belongs_to :servicio_anterior, :class_name => 'TipoServicio'
  belongs_to :formapago
  belongs_to :usuario

   # ESTADOS DE PLANES
   PENDIENTE = 0
   APROBADO = 1
   VENCIDO = 2
   RECHAZADO = 3
end
