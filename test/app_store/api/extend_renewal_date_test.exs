defmodule AppStore.API.ExtendRenewalDateTest do
  use AppStore.TestCase, async: false

  alias AppStore.API.ExtendRenewalDate

  describe "extend_renewal_date/3" do
    test "Get a history of transactions", %{bypass: bypass, app_store: app_store} do
      Bypass.expect_once(bypass, "PUT", "/inApps/v1/subscriptions/extend/the-transaction-id", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("server", "daiquiri/3.0.0")
        |> Plug.Conn.resp(401, "Unauthenticated\n\nRequest ID: PXYVB35MOBBC5TL6UOXY6DGJGY.0.0\n")
      end)

      {:ok, %AppStore.API.Response{body: body, status: status}} =
        ExtendRenewalDate.extend_renewal_date(
          app_store.api_config,
          "token",
          "the-transaction-id",
          %{}
        )

      assert status === 401
      assert body === "Unauthenticated\n\nRequest ID: PXYVB35MOBBC5TL6UOXY6DGJGY.0.0\n"
    end
  end
end
