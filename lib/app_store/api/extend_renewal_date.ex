defmodule AppStore.API.ExtendRenewalDate do
  @moduledoc """
  The module for extending renewal date
  """

  alias AppStore.API.{Config, Error, Response, HTTP}

  @type original_transaction_id :: String.t()

  @path_prefix "/inApps/v1/subscriptions/extend"

  @doc """
  Extend the renewal date of a customer’s active subscription using the original transaction identifier.

  Official documentation: https://developer.apple.com/documentation/appstoreserverapi/extend_a_subscription_renewal_date
  """
  @spec extend_renewal_date(Config.t(), String.t(), original_transaction_id, map) ::
          {:error, Error.t()} | {:ok, Response.t()}
  def extend_renewal_date(%Config{} = api_config, token, original_transaction_id, body)
      when is_map(body) do
    path = "#{@path_prefix}/#{original_transaction_id}"

    HTTP.put(api_config, token, path, body)
  end
end
