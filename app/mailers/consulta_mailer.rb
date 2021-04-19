class ConsultaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.consulta_mailer.send_consulta.subject
  #
  def send_consulta(nombre,email,consulta)
    @greeting = "Hi"
    @nombre = nombre
    @email = email
    @consulta = consulta
    mail to: "to@example.org"
  end
end
