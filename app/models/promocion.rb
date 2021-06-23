class Promocion < ApplicationRecord
  belongs_to :comercio
  belongs_to :usuario
  belongs_to :formapago
  before_create :gen_code
  has_one_attached :imagen, dependent: :destroy
  # ESTADOS DE PROMOCION
  enum estado: %i[pendiente aprobado gratuito]

  #estado: 
  #0:default/pendiente, 
  #1:habilitado, 
  #2:nohabilitado, 
  #3:procesada y terminada
  
  private
  def gen_code
    self.codigo = SecureRandom.urlsafe_base64(4).downcase
  end
end
