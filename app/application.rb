class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples, Carrots"]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
        if @@cart.length < 1
          resp.write "Your cart is empty"
        else
          @@cart.each do |item|
            resp.write "#{item}\n"
          end
        end
    elsif req.path.match(/add/)
      get_term = req.params["item"]
        if @@items.include?(get_term)
          @@cart << get_term
          resp.write "added #{get_term}\n"
        else
          resp.write "Error #{get_term} not an item\n"
        end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
