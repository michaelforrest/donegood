defmodule Donegood.AuthErrorHandler do
  def unauthenticated(conn, _) do
    url  = "/"
    html = Plug.HTML.html_escape(url)
    body = "<html><body>You are being <a href=\"#{html}\">redirected</a>.</body></html>"

    flash = Map.put(Map.get(conn.private, :phoenix_flash), "error", "Unauthorized!, Please sign in.")

    conn
    |> Plug.Conn.put_private(:phoenix_flash, flash)
    |> Plug.Conn.put_resp_header("location", url)
    |> Plug.Conn.send_resp(conn.status || 302, body)
  end  
end
