defmodule GeradorDeSenhas.Logica.Servidor do
  use GenServer

  def init(_), do: {:ok, ""}

  def handle_call({:gerar, possi, n}, _, estado) do
    p = String.to_charlist(possi)

    s =
      for _ <- 1..n do
        Enum.random(p)
      end

    {:reply, to_string(s), estado}
  end
end
