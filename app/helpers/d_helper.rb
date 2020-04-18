module DHelper
  def bulma_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |message| content_tag(:li, message) }.join
    sentence = I18n.t(
      'errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase
    )

    html = <<-HTML
    <div class="notification is-danger">
      <button type="button" class="delete"></button>
      <div class="content">
        <h4>#{sentence}</h4>
        <ul>#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end

  def bulma_divise_flash_messages!
    return '' if flash.empty?

  html_tag = ""
    flash.each do |name, message|
      boots_bulma_map = {'alert' => 'danger', 'notice' => 'success'}
      html_tag += "<div class=\"notification is-#{boots_bulma_map[name]}\">
      <button class=\"delete\"></button>
      #{message}
      </div>"

    end
  html_tag.html_safe
  end
end
