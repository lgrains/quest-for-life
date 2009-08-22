class SystemMailer < ActionMailer::Base
  def test_message(message = 'This is a test.')
    @subject = 'This is a test message'
    @body = message
    @recipients = 'rumble09@patientslikeme.com'
    @from = 'donotreply@quest-for-life.com'
  end
end
