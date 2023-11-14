class ApplicationService
  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_url(url)
    conn.get(url)
  end

  # could I use polymorphism to put conn in here?
  
  # def conn(host)
  #   Faraday.new(url: host)
  # end

  # def get_url(host, url)
  #   conn(host).get(url)
  # end

  # So yes, I could do this! But does it make sense to do it? Probably not. From a developer empathy POV, I actually don't think it is much of an improvement.
  # This is a good example of how polymorphism can be used to make code more DRY, but it's not always the best choice.
end