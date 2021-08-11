module MatchRoomsHelper
  def duration_display(duration_value)
    duration = ActiveSupport::Duration.build(duration_value).parts

    format('%02d:%02d:%02d', (duration[:hours] || 0), duration[:minutes] || 0, duration[:seconds] || 0)
  end
end
