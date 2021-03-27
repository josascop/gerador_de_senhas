defmodule GeradorDeSenhasWeb.GeradorController do
  use GeradorDeSenhasWeb, :controller
  alias GeradorDeSenhas.Logica

  def index(conn, _params) do
    conn
    |> render("index.html", senha: "jaskhgdjhsgah")
  end

  def new(%Plug.Conn{params: params} = conn, _) do
    n =
      case Map.get(params, "n") do
        "" -> 0
        _ -> String.to_integer(Map.get(params, "n"))
      end

    case n < 5 || n > 50 do
      true ->
        conn
        |> put_flash(:error, "A senha gerada deve ter entre 5 e 50 caracteres")
        |> redirect(to: "/")

      _ ->
        op = Map.get(params, "opcoes")

        senha = Logica.gerar_senha(n, op)

        conn
        |> put_flash(:info, "Senha gerada: #{senha}")
        |> redirect(to: "/")
    end
  end
end
