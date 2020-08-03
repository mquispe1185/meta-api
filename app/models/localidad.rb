class Localidad < ApplicationRecord
  belongs_to :departamento
  belongs_to :provincia
end
