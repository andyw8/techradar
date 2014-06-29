# stolen from thoughtbot/learn
module StubCurrentUserHelper
  def stub_current_user_with(user)
    allow(controller).to receive(:current_user) { user }
  end
end
