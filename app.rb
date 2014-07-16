require "sinatra"
require "rack-flash"
require "gschool_database_connection"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :root, :layout => :main_layout
  end

  post "/email_signup" do
    if params[:name] == "" && params[:email] == ""
      flash[:notice] = "Please enter a name and email."
      redirect "/"
    elsif params[:name] == ""
      flash[:notice] = "Please enter a name."
      redirect "/"
    elsif params[:email] == ""
      flash[:notice] = "Please enter an email."
      redirect "/"
    end
    begin
      @database_connection.sql("INSERT INTO email (name, email) VALUES ('#{params[:name]}','#{params[:email]}')")
      flash[:notice] = "Thanks, #{params[:name]} for giving the Blue Hat some email food. #{params[:email]} is delicious!"
      redirect "/"
    rescue
      redirect "/"
    end
  end
end