class RouteError < StandardError
  def message
    'Route is not set or train is at the end-station'
  end
end