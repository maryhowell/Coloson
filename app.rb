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
    else
      status 422
      json(status: "error", error:"Invalid number: #{params["number"]}")
    end
  end

  delete "/numbers/odds" do
    delete_number = params["number"]
    DB["odds"].delete(delete_number.to_i)
    200
  end

  get "/numbers/primes" do
    unless DB["primes"]
      DB["primes"] = []
    end
    json DB["primes"]
  end

  post "/numbers/primes" do
    add_number = params["number"]
    if add_number == add_number.to_i.to_s
      if DB["primes"]
        DB["primes"].push(add_number.to_i)
        200
      else
        DB["primes"] = [add_number.to_i]
        200
      end
    else
      status 422
      json(status: "error", error:"Invalid number: #{params["number"]}")
    end
  end

  get "/numbers/primes/sum" do
    unless DB["primes"]
      DB["primes"] = []
    end
    json DB["primes"]
    body json(status: "ok", sum: DB["primes"].inject(:+))
  end

  get "/numbers/mine" do
    unless DB["mine"]
      DB["mine"] = []
    end
    json DB["mine"]
  end

  post "/numbers/mine" do
    add_number = params["number"]
    if add_number == add_number.to_i.to_s
      if DB["mine"]
        DB["mine"].push(add_number.to_i)
        200
      else
        DB["mine"] = [add_number.to_i]
        200
      end
    else
      status 422
      json(status: "error", error:"Invalid number: #{params["number"]}")
    end
  end

  get "/numbers/mine/product" do
    product = DB["mine"].inject(:*)
    if product < 1000
      unless DB["mine"]
        DB["mine"] = []
      end
      json DB["mine"]
      body json(status: "ok", product: DB["mine"].inject(:*))
    else
      status 422
      json(status: "error", error: "Only paid users can multiply numbers that large")
    end
  end

  get "/numbers/numberwang" do
    unless DB["numberwang"]
      DB["numberwang"] = []
    end
    json DB["numberwang"]
  end

  post "/numbers/numberwang" do
    numberwang = params["number"]
    if add_number == add_number.to_i.to_s
      if DB["numberwang"]
        DB["numberwang"].push(add_number.to_i)

        puts"you got numberwang!?"
        200
      else
        DB["numberwang"] = [add_number.to_i]
        puts "not numberwang..."
        200
      end
    else
      status 422
      json(status: "error", error:"Not numberwang")
    end
  end
end

Coloson.run! if $PROGRAM_NAME == __FILE__
