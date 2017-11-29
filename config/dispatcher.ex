defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  match "/sessions/*path" do
      Proxy.forward conn, path, "http://login/sessions/"
  end

  match "/concepts/*path" do
    Proxy.forward conn, path, "http://resource/concepts/"
  end

  # export microservice expects the parameters to follow the "export" part of the call, please don't remove '/' unless route changed in service
  match "/export*path" do
    Proxy.forward conn, path, "http://export/"
  end

  match "/tasks/*path" do
    Proxy.forward conn, path, "http://resource/tasks/"
  end

  match "/label-roles/*path" do
    Proxy.forward conn, path, "http://resource/label-roles/"
  end

  match "/concept-labels/*path" do
    Proxy.forward conn, path, "http://resource/concept-labels/"
  end

  match "/concept-schemes/*path" do
    Proxy.forward conn, path, "http://resource/concept-schemes/"
  end

  match "/taxonomies/*path" do
    Proxy.forward conn, path, "http://resource/taxonomies/"
  end

  match "/hierarchies/*path" do
    Proxy.forward conn, path, "http://resource/hierarchies/"
  end

  match "/notifications/*path" do
    Proxy.forward conn, path, "http://resource/notifications/"
  end

  match "/validation-result-collections/*path" do
    Proxy.forward conn, path, "http://resource/validation-result-collections/"
  end

  match "/validation-results/*path" do
    Proxy.forward conn, path, "http://resource/validation-results/"
  end

  match "/hierarchy/*path" do
    Proxy.forward conn, path, "http://hierarchyapi/hierarchies/"
  end

  match "/structure/*path" do
    Proxy.forward conn, path, "http://hierarchyapi/structures/"
  end

  match "/concept-relations/*path" do
    Proxy.forward conn, path, "http://resource/concept-relations/"
  end

  match "/accounts/*path" do
    Proxy.forward conn, path, "http://resource/accounts/"
  end

  match "/users/*path" do
    Proxy.forward conn, path, "http://resource/users/"
  end

  match "/groups/*path" do
    Proxy.forward conn, path, "http://resource/groups/"
  end

  match "/cache/*path" do
    Proxy.forward conn, path, "http://resource/"
  end

  match "/upload/*path" do
		Proxy.forward conn, path, "http://importer:8080/upload"
  end
  match "/comments/*path" do
    Proxy.forward conn, path, "http://resource/comments/"
  end
  match "/comment-notifications/*path" do
    Proxy.forward conn, path, "http://resource/comment-notifications/"
  end
  match "/notification-assignments/*path" do
    Proxy.forward conn, path, "http://resource/notification-assignments/"
  end
  match "/kpis/*path" do
    Proxy.forward conn, path, "http://kpisapi/kpis/"
  end

  # This is where you can call any method of the validation microservice
  match "/validation/*path" do
    Proxy.forward conn, path, "http://validation/"
  end

  # This is a handy endpoint to get the resources "validations" provided by
  # the validation microservice
  match "/validations/*path" do
    Proxy.forward conn, path, "http://validation/"
  end

  match "/cleanup/*path" do
    Proxy.forward conn, path, "http://cleanup/"
  end

  # please do not change this route unless you also change them in the micro service
  match "/translate*path" do
    Proxy.forward conn, path, "http://dictionary/"
  end
  match "/poetry-tasks/*path" do
    Proxy.forward conn, path, "http://resource/poetry-tasks/"
  end
  match "/indexer/*path" do
    Proxy.forward conn, path, "http://indexer:8080/"
  end
  
  match "/translation-xml-import/*path" do
    Proxy.forward conn, path, "http://translation-xml-import/"
  end
end
