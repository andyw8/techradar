# Used by routes.rb
class UsernameConstraint
  def self.matches?(request)
    User.find_by(username: request.params[:username]).present?
  end
end
