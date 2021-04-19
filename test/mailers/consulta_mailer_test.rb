require 'test_helper'

class ConsultaMailerTest < ActionMailer::TestCase
  test "send_consulta" do
    mail = ConsultaMailer.send_consulta
    assert_equal "Send consulta", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
