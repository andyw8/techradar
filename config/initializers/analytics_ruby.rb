if Rails.env.test?
  class Analytics
    def self.track(*)
    end
  end
else
  Analytics = Segment::Analytics.new(
    write_key: ENV.fetch("SEGMENT_WRITE_KEY"),
    on_error: proc { |_status, msg| print msg }
  )
end
