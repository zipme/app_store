defmodule AppStore.API.NotificationHistory do
  @moduledoc """
  The module for Notification History
  """

  alias AppStore.API.{Config, Response, Error, HTTP}

  @type paginationToken :: String.t() | nil
  @type params :: %{
    startDate: integer(),
    endDate: integer(),
    notificationType: String.t() | nil,
    transactionId: String.t() | nil
  }

  @path_prefix "/inApps/v1/notifications/history"

  @doc """
  Get all notification history

  Official documentation: https://developer.apple.com/documentation/appstoreserverapi/get_notification_history
  """
  @spec get_notification_history(Config.t(), String.t(), paginationToken, params) ::
          {:error, Error.t()} | {:ok, Response.t()}
  def get_notification_history(
        %Config{} = api_config,
        token,
        pagination_token,
        params
      ) do
    path =
      if is_nil(pagination_token) do
        @path_prefix
      else
        query_string = URI.encode_query(%{paginationToken: pagination_token})
        "#{@path_prefix}?#{query_string}"
      end

    HTTP.post(api_config, token, path, params)
  end
end
