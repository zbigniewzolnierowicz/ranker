defmodule RankerWeb.ErrorView do
  use RankerWeb, :view

  def render(<< error_code :: binary-size(3), ".json" >>, %{message: message, details: details}) do
    IO.puts("Matched the catch-all")
    %{
      status: error_code,
      message: message,
      details: details
    }
  end

  def render(<< error_code :: binary-size(3), ".json" >>, %{message: message}) do
    %{
      status: error_code,
      message: message
    }
  end

  def render("404.json", %{details: details}) do
    %{
      status: 404,
      message: "Not found.",
      details: details
    }
  end

  def render("404.json", _params) do
    %{
      status: 404,
      message: "Not found.",
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
