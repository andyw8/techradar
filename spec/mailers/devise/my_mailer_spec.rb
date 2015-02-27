require "rails_helper"

describe Devise::MyMailer do
  it "welcomes the person by name" do
    user = create(:user, name: "Joe Bloggs")

    mail = described_class.confirmation_instructions(user, 'token').deliver_now

    expect(mail.body).to match(/Welcome Joe Bloggs/)
  end
end
