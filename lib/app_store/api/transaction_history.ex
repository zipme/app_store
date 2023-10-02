defmodule AppStore.API.TransactionHistory do
  @moduledoc """
  The module for Transaction History
  """

  alias AppStore.API.{Config, Response, Error, HTTP}

  @type original_transaction_id :: String.t()
  @type revision :: String.t() | nil
  @type revoke :: Boolean.t() | nil

  @path_prefix "/inApps/v1/history"

  @doc """
  Get a customer’s transaction history, including all of their in-app purchases in your app.

  Official documentation: https://developer.apple.com/documentation/appstoreserverapi/get_transaction_history
  """
  @spec get_transaction_history(Config.t(), String.t(), original_transaction_id, revision, revoke) ::
          {:error, Error.t()} | {:ok, Response.t()}
  def get_transaction_history(
        %Config{} = api_config,
        token,
        original_transaction_id,
        revision \\ nil,
        revoke \\ nil
      ) do
    do_get_transaction_history(api_config, token, original_transaction_id, revision, revoke)
  end

  defp do_get_transaction_history(%Config{} = api_config, token, original_transaction_id, "", "") do
    do_get_transaction_history(api_config, token, original_transaction_id, nil, nil)
  end

  defp do_get_transaction_history(
         %Config{} = api_config,
         token,
         original_transaction_id,
         nil,
         nil
       ) do
    path = "#{@path_prefix}/#{original_transaction_id}"

    HTTP.get(api_config, token, path)
  end

  defp do_get_transaction_history(
         %Config{} = api_config,
         token,
         original_transaction_id,
         revision,
         revoke
       ) do
    query = %{revision: revision, revoke: revoke}

    query_string = URI.encode_query(query)

    path = "#{@path_prefix}/#{original_transaction_id}?#{query_string}"

    HTTP.get(api_config, token, path)
  end
end
