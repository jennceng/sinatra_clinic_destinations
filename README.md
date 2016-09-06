### What is Sinatra?

* Sinatra is a free and open-source lightweight web application framework
* Unlike other ruby frameworks (such as Rails), Sinatra emphasizes a minimalistic approach to development, only offering what is essential to handle HTTP requests and deliver responses to clients (your browser)
* It is ideal for teaching HTTP since its syntax in defining endpoints use HTTP verbs in the pattern `verb ‘route’ do`

---

### Routes

* Routes can essentially be seen as methods in ruby of a specific syntax
* To declare a route you supply the HTTP verb to respond to, the URL, and a block you want executed if someone travels to / hits that route

* for example many routes may have the same URL, but they can be triggered / called based on the type of HTTP verb

```ruby
require 'sinatra'

get '/destinations' do
  # triggered via GET
end

post '/destinations' do
  # triggered via POST, such as the submission of a form with action 'POST'
end
```

* just as Ruby methods only have one return value, and once returned jumps out of the method even if there are more lines of code in the block, Sinatra can only have one return, for example redirecting to a different route
* if the situation calls for it you can use conditionals to redirect / render things based on conditions 


```ruby
# the pry after the redirect will never be hit because the redirect will cause an exit of the block / method
post '/destinations' do
  destination = params[:destination]

  File.open('destination.txt', 'a') do |file|
    file.puts(destination)
  end

  redirect '/'
  binding.pry
end
```

---

### Params

* the params hash stores stores query string and form data, this is how we pass data from our client to the server
* a hash is just made up of key-value pairs, what determines the keys?

* YOU (obvi, as Dani would say)

* in forms, this is the ‘name’ part of your form input
* for queries it would be defined in your url of your route in the server file

```ruby
get '/destinations/:country' do
  @destination = params[:name]
  binding.pry
  erb :show
end
```

![Alt text](http://i.imgur.com/KY3Izqb.png)

the symbol id becomes the key in our key-value pair of our params hash, so if it was defined as

```ruby
get '/destinations/:name' do
  @destination = params[:name]
  binding.pry
  erb :show
end
```

now going to that same url `http://localhost:4567/destinations/korea`, we still have the same value of this time with a key of “name"

![Alt text](<http://i.imgur.com/8Ck7OKI.png>)

---

### Instance Variables

* this is how we pass data from our server to our views, we commonly use `erb` templates as to dynamically generate our html

```ruby
# server.rb
get '/' do
  @destinations = File.readlines('destinations.txt')

  erb :index
end
```

---

### Views

* sinatra will default to look in your views folder

```ruby
# server.rb
# looks in views folder for index.erb
get '/' do
  @destinations = File.readlines('destinations.txt')

  erb :index
end
```

* if your template is in a subfolder, for example if you follow a pattern to have a folder for each model so each subfolder can have its own index.erb, you need to convert the string path to a symbol such as

```ruby
erb :'destinations/index'
```

---

Debugging
=========

### Start by restarting your server

* often when we make changes on the server file and we don’t see that reflected on the webpage it is because we forgot to restart the server

### Throw a pry in it

* erb is just embedded ruby, you can use pry simply by throwing `<% binding.pry %>` into your erb file!

---
### Destination Bucket List
```
checklist -
[ ]  visiting ‘/destinations’ should show me an unordered list of all the desti˜nations from the txt file with each destination as its own <li>
[ ]  as a user I want to be able to add destinations via a form that should add it to ‘destinations.txt’, then it should redirect me to the page I was just on, ‘/destinations’, so I can see all the previous entries plus the new destination I just submitted
[ ]  root should redirect to “/destinations"
```
