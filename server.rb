require 'sinatra'
require 'pry'

get "/" do
  redirect "/destinations"
end

get "/destinations" do
  @destinations = File.readlines('destinations.txt')

  erb :index
end

post "/destinations" do
  new_destination = params[:destination]
  File.open('destinations.txt', 'a') do |file|
    file.puts(new_destination)
  end

  # erb :index
  redirect '/destinations'
end
