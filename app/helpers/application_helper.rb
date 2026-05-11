module ApplicationHelper
  def markdown(text)
    return "" if text.blank?

    renderer = Redcarpet::Render::HTML.new(
      hard_wrap: true,
      filter_html: true,
      no_images: true,
      no_styles: true
    )

    options = {
      autolink: true,
      no_intra_emphasis: true,
      strikethrough: true,
      underline: true
    }

    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
