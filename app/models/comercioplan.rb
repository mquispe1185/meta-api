class Comercioplan < ApplicationRecord
  belongs_to :comercio
  belongs_to :tipo_servicio
  belongs_to :formapago
  belongs_to :usuario
end
