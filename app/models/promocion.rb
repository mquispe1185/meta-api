class Promocion < ApplicationRecord
  belongs_to :comercio
  belongs_to :usuario
  belongs_to :formapago
  before_create :gen_code
  private
  def gen_code
    self.codigo = SecureRandom.urlsafe_base64(4).downcase
  end
end
