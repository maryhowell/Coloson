require "sinatra/base"
require "sinatra/json"
require "pry"

DB = {}

class Coloson < Sinatra::Base

  set :show_exceptions, false
 error do |e|
   raise e
 end

  def self.reset_database
    DB.clear
  end

  get "/numbers/evens" do
    unless DB["evens"]
      DB["evens"] = []
    end
    json DB["evens"]
  end

  post "/numbers/evens" do
    add_number = params["number"]
    if add_number == add_number.to_i.to_s
      if DB["evens"]
        DB["evens"].push(add_number.to_i)
        200
      else
        DB["evens"] = add_number.to_i
        200
      end
    end
  end

  get "/numbers/odds" do
    unless DB["odds"]
      DB["odds"] = []
    end
    json DB["odds"]
  end

  post "/numbers/odds" do
    add_number = params["number"]
    if add_number == add_number.to_i.to_s
      if DB["odds"]
        DB["odds"].push(add_number.to_i)
        200
      else
        DB["odds"] = [add_number.to_i]
        200
      end
    end
  end

  delete "/numbers/odds" do
    delete_number = params["number"]
    DB["odds"].delete(delete_number.to_i)
    200
  end



end

Coloson.run! if $PROGRAM_NAME == __FILE__
