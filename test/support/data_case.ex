defmodule Martins.Test.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Martins.Test.DataCase

      use Plug.Test
    end
  end

  def json_response(conn, status) do
    body = response(conn, status)

    case Jason.decode(body) do
      {:ok, body} ->
        body

      {:error, _} ->
        raise "could not decode JSON body"
    end
  end

  defp response(%Plug.Conn{status: status, resp_body: body}, given) do
    given = Plug.Conn.Status.code(given)

    if given == status do
      body
    else
      raise "expected response with status #{given}, got: #{status}, with body:\n#{body}"
    end
  end
end
