defmodule GeradorDeSenhas.Logica do
  @letras "abcdefghijklmnopqrstuvwxyz"
  @simbolos "\'\"\\|!@#$%¨&*()-_+=[{]}/?;:,<.>£¢¬"
  @numeros "0123456789"

  @servidor GeradorDeSenhas.Logica.Servidor

  def start_link(), do: GenServer.start_link(@servidor, "", name: @servidor)

  def gerar_senha(n, op) do
    {_, p} =
      {op, ""}
      |> minusculas()
      |> maiusculas()
      |> simbolos()
      |> numeros()

    GenServer.call(@servidor, {:gerar, p, n})
  end

  defp minusculas({op, str}) do
    case "min" in op do
      true -> {op, str <> @letras}
      _ -> {op, str}
    end
  end

  defp maiusculas({op, str}) do
    case "mai" in op do
      true -> {op, str <> String.upcase(@letras)}
      _ -> {op, str}
    end
  end

  defp simbolos({op, str}) do
    case "sim" in op do
      true -> {op, str <> @simbolos}
      _ -> {op, str}
    end
  end

  defp numeros({op, str}) do
    case "num" in op do
      true -> {op, str <> @numeros}
      _ -> {op, str}
    end
  end
end
