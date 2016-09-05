require 'Sinatra'
require 'pry'

get '/' do
  redirect '/destinations'
end

get '/destinations' do
  destinations = File.readlines('destinations.txt')

  erb :index
end

post '/destinations' do
  destination = params[:destination]

  File.open('destinations.txt', 'w') do |file|
    file.puts(destination)
  end

  redirect '/destinations'
end
