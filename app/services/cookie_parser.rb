module CookieParser
  class << self
    def parse(cookie_string)
      cookie_string
        .split('; ')
        .map { |c| c.split('=') }
        .each_with_object({}) do |element, result|
          result[element.first] = element.last

          result
        end
    end
  end
end
