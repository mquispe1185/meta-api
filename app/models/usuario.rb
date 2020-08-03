# frozen_string_literal: true

class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  include DeviseTokenAuth::Concerns::User

  belongs_to :rol, optional: true
  belongs_to :provincia, optional: true
  belongs_to :departamento, optional: true
  belongs_to :localidad, optional: true
end
