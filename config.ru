require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'demo'


  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end

  get '/' do
    erb 'index'.to_sym, layout: :static_layout
  end
  # Sinatra doesn't support overriding routes. The routes are evaluated first come first serve.
  # In this case, we want our route for '/' to come first, so we put it at the front of the routes array. hacky? yeah
  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)

  get '/faq' do
    erb 'faq'.to_sym, layout: :static_layout
  end

  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)


end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application