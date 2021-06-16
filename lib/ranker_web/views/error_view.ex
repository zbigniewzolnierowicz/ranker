defmodule RankerWeb.ErrorView do
  use RankerWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".

  def render("403.json", %{message: message, details: details}) do
    %{
      status: 403,
      message: message,
      details: details
    }
  end

  def render("403.json", %{message: message}) do
    %{
      status: 403,
      message: message
    }
  end

  def render("403.json", %{details: details}) do
    %{
      status: 403,
      message: "Forbidden.",
      details: details
    }
  end

  def render("403.json", _params) do
    %{
      status: 403,
      message: "Forbidden.",
    }
  end

  def render("401.json", %{message: message, details: details}) do
    %{
      status: 401,
      message: message,
      details: details
    }
  end

  def render("401.json", %{message: message}) do
    %{
      status: 401,
      message: message
    }
  end

  def render("401.json", %{details: details}) do
    %{
      status: 401,
      message: "Unauthorized.",
      details: details
    }
  end

  def render("401.json", _params) do
    %{
      status: 401,
      message: "Unauthorized.",
    }
  end

  def render("409.json", %{message: message, details: details}) do
    %{
      status: 409,
      message: message,
      details: details
    }
  end

  def render("409.json", %{message: message}) do
    %{
      status: 409,
      message: message
    }
  end

  def render("409.json", %{details: details}) do
    %{
      status: 409,
      message: "Conflict with the existing resource.",
      details: details
    }
  end

  def render("409.json", _params) do
    %{
      status: 409,
      message: "Conflict with the existing resource.",
    }
  end

  def render("400.json", %{message: message, details: details}) do
    %{
      status: 400,
      message: message,
      details: details
    }
  end

  def render("400.json", %{message: message}) do
    %{
      status: 400,
      message: message
    }
  end

  def render("400.json", %{details: details}) do
    %{
      status: 400,
      message: "Bad request.",
      details: details
    }
  end

  def render("400.json", _params) do
    %{
      status: 400,
      message: "Bad request.",
    }
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
