# frozen_string_literal: true

module TitleHelper
  def title(title_text, subtitle = nil)
    content_for(:title) { title_text }
    content_tag(:h1) do
      concat title_text
      concat content_tag(:small, subtitle, class: 'text-muted') if subtitle
    end
  end
end
