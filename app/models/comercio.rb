class Comercio < ApplicationRecord
  belongs_to :provincia
  belongs_to :departamento
  belongs_to :localidad
  belongs_to :usuario
  belongs_to :rubro
  has_many :horarios
end
