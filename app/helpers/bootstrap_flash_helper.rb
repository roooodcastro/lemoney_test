# frozen_string_literal: true

module BootstrapFlashHelper
  # Gera e retorna os flashs vindos do controller para exibir na tela.
  def bootstrap_flash
    capture do
      flash.each do |type, messages|
        bootstrap_alerts_for_type(bootstrap_flash_type(type), messages)
      end
    end
  end

  def bootstrap_alert(type, title_text, dismissable = true)
    content_tag('div', class: "alert alert-#{type} fade show", role: 'alert') do
      concat bootstrap_close_button('alert') if dismissable
      concat content_tag('strong', title_text) if title_text
      concat(content_tag(:span, capture { yield }))
    end
  end

  def bootstrap_close_button(data_dismiss = 'alert')
    span = content_tag('span', '×', aria: { hidden: true })
    button_tag(span, class: 'close', data: { dismiss: data_dismiss },
               aria: { label: 'Close' })
  end

  def bootstrap_alerts_for_type(type, messages)
    return if type.blank?
    Array(messages).each do |msg|
      concat(bootstrap_alert(type, nil) do
        simple_format(msg, {}, wrapper_tag: 'span')
      end)
    end
  end

  def bootstrap_flash_type(type)
    { notice: :success, alert: :warning, error: :danger }[type.to_sym]
  end
end
