module ApplicationHelper
  def display_base_errors(resource)
    errors = resource.errors
    return "" if errors.empty? || errors[:base].empty?
    messages = errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>

      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def title(text)
    content_for(:title, text)
    content_tag(:h1, text)
  end

  def can?(action, resource = nil)
    case action
    when :create_radar
      current_user.present?
    when :edit_radar, :delete_radar
      resource.owned_by?(current_user)
    when :create_blip
      radar = resource
      radar.owned_by?(current_user)
    when :edit_blip, :delete_blip
      blip = resource
      blip.radar.owned_by?(current_user)
    else
      fail "Unknown action #{action} for #{resource}"
    end
  end

  def admin
    content_tag("div", class: "admin") do
      yield if current_user && current_user.admin?
    end
  end

  def body_classes
    [params[:controller], params[:action]].join(" ")
  end
end
