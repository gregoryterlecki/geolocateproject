defmodule Geolocate.PageController do
  use Geolocate.Web, :controller
  use HTTPotion.Base

  def index(conn, _params) do
    client_ip = conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    locrequest = "http://ip-api.com/json/" <> client_ip
    locresponse = HTTPotion.get(locrequest)
    loc = Poison.decode!(locresponse.body)
    lat = loc["lat"]
    lon = loc["lon"]
    map = "https://www.google.com/maps/embed/v1/search?key=AIzaSyCThWvNhuXcAypI_ABWiqSyyWBzAUMncjQ&q=" <> Float.to_string(lat) <> "," <> Float.to_string(lon)
    render conn, "index.html", loc: loc , map: map
  end
end
