module CookieParser
  class << self
    def parse(cookie_string)
      cookie_string
        .split('; ')
        .map { |c| c.split('=') }
        .inject({}) { |result, element| result[element.first] = element.last; result }
    end
  end
end

