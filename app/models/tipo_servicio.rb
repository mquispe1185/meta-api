class TipoServicio < ApplicationRecord
  has_many :comercios
  GRATUITO = 1
  BASICO = 2
  ESTANDAR = 3
  PREMIUM = 4
end
