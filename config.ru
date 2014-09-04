require 'dashing'
require 'mandrill'
require 'httparty'

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
    erb :index, layout: :static_layout
  end
  # Sinatra doesn't support overriding routes. The routes are evaluated first come first serve.
  # In this case, we want our route for '/' to come first, so we put it at the front of the routes array. hacky? yeah
  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)

  get '/faq' do
    erb :faq, layout: :static_layout
  end

  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)

  get '/password_reset/:token' do
    @token = params[:token]
    erb :password_reset, layout: :static_layout
  end

  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)


  get '/fitbit_access/:user_id' do # TODO(Charles): Should not use naked IDs like this, as it isn't secure.
    @user_id = params[:user_id]
    erb :fitbit_access, layout: :static_layout
  end

  Sinatra::Application.routes["GET"].unshift(Sinatra::Application.routes["GET"].pop)




  post '/contact' do
    m = Mandrill::API.new('YjmkuIiDdE6ItQ02CTMPoQ')
    message = {
        :subject=> "Contact from from #{params[:name]}",
        :from_name=> "FitStack Landing Page",
        :text=> params.to_s,
        :to=>[
            {
                :email=> "charles@fitbookr.com",
                :name=> "Charles"
            },
            {
                :email=> "james@fitbookr.com",
                :name=> "JamJams Park"
            }
        ],
        :from_email => 'charles@fitstack.co'
    }
    sending = m.messages.send message
    if sending # TODO(Charles): check to see if message was sent.
      200
    else
      422
    end

  end


end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets

end

run Sinatra::Application