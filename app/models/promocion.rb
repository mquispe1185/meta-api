class Promocion < ApplicationRecord
  belongs_to :comercio
  belongs_to :usuario
end
