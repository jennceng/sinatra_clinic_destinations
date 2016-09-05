### What is Sinatra?

* Sinatra is a free and open-source lightweight web application framework
* Unlike other ruby frameworks (such as Rails), Sinatra emphasizes a minimalistic approach to development, only offering what is essential to hand HTTP requests and deliver responses to clients (your browser)
* It is ideal for teaching HTTP since its syntax in defining endpoints use HTTP verbs in the pattern `verb ‘route’ do`

---

### Routes

* Routes can essentially be seen as methods in ruby of a specific syntax
* To declare a routes you supply the HTTP verb to respond to, the URL, and a block you want executed if that someone travels to that route

* for example many routes may have the same URL, but they can be triggered / called based on the type of HTTP verb

```ruby
require 'sinatra'

get '/ingredients' do
  # triggered via GET
end

post '/ingredients' do
  # triggered via POST, such as the submission of a form with action 'POST'
end
```

* just as Ruby methods only have one return value, and once returned jumps out of the method even if there are more lines of code in the block, Sinatra can only have one return, for example redirecting to a different route

```ruby
# the pry after the redirect will never be hit because the redirect will cause an exit of the block / method
post '/ingredients' do
  ingredient = params[:ingredient]

  File.open('ingredients.txt', 'a') do |file|
    file.puts(ingredient)
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
get '/ingredients/:id' do
  binding.pry
end
```

![Alt text](http://i.imgur.com/Z5M5puI.png)

the symbol id becomes the key in our key-value pair of our params hash, so if it was defined as

```ruby
get '/ingredients/:name' do
  binding.pry
end
```

now going to that same url `<http://localhost:4567/ingredients/brussels>`, we still have the same value of brussels, this time with a key of “name"

![Alt text](http://i.imgur.com/EZIPMKZ.png)

---

### Instance Variables

* this is how we pass data from our server to our views, we commonly use `erb` templates as to dynamically generate our html

```ruby
# server.rb
get '/' do
  @ingredients = File.readlines('ingredients.txt')

  erb :index
end
```

```ruby
# views/index.erb
  <ul>
      <% @ingredients.each do |ingredient| %>
        <li><%= ingredient %></li>
      <% end %>
  </ul>
```
