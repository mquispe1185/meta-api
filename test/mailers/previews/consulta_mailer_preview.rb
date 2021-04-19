# Preview all emails at http://localhost:3000/rails/mailers/consulta_mailer
class ConsultaMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/consulta_mailer/send_consulta
  def send_consulta
    ConsultaMailer.send_consulta
  end

end
