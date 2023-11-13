class ApplicationService
  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_url(url)
    conn.get(url)
  end
end