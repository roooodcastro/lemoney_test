# frozen_string_literal: true

module ApplicationHelper
  def seconds_to_time(seconds)
    time_parts = [seconds / 3600, seconds / 60 % 60, seconds % 60]
    time_parts.map! { |part| part.to_i.to_s.rjust(2, '0') }
    label_parts = [:h, :m, :s]
    parts = time_parts.zip(label_parts).map(&:join)
    parts.join(':')
  end
end
