# stolen from thoughtbot/learn
module StubCurrentUserHelper
  def stub_current_user_with(user)
    controller.stub(current_user: user)
  end
end
