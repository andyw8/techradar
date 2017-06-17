module ApplicationHelper
  def display_base_errors(resource)
    # :nocov:
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
    # :nocov:
  end

  def title(text)
    content_for(:title, text)
    content_tag(:h1, text)
  end

  def can?(action, resource = nil)
    Ability.new(current_user).can?(action, resource)
  end

  def body_classes
    [params[:controller], params[:action]].join(" ")
  end
end
