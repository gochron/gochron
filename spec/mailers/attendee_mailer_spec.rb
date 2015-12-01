require "rails_helper"

RSpec.describe AttendeeMailer, type: :mailer do
  describe "notify_attendee" do
    let(:mail) { AttendeeMailer.notify_attendee }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify attendee")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
