module Config

  MAX_PRICE = 13_000 # my budget for PRIUS

  # MAX_PRICE = 30_000 # there's no point in paying more than a tesla if you just want a self driving car, unless you're really an OP fan :D 

  def default_params
    {
      # cheapest car with openpilot in UK

      make: "TOYOTA",
      model: "PRIUS",

      # color - by default, any color, you can restrict color via:     
      # colour: "pick-your-color",
      # colour: "White",

      # make: "HONDA",
      # model: "CIVIC",
      
      # make: "HONDA",
      # model: "CR-V",

      # not many corollas around here, :/ ( :D lol )
      # make: "TOYOTA",
      # model: "COROLLA",

      # make: "TOYOTA",
      # model: "AURIS",

      # make: "KIA",
      
      # filter by body type:
      # "body-type": "SUV",

      # use exhotic car manufacturers: 
      # make: "HYUNDAI",
      # "body-type": "SUV", # tucson really :D

      # ok sorry this wasn't a good joke :D

      # note - remember:
      # we are looking for "2017+" models, any car sold in 2016 as new model with an LKAS camera are ok
      "year-from": 2016,

      radius: 50, # quite ok for a car search
      # radius: 20,  # very close
      # radius: 100, # the whole area / country

      postcode: "E14 3RS",
      transmission: "Automatic",

      # select only trade sellers
      # "seller-type": "trade",

      # unused options:
      #
      # onesearchad: "Used",
      # "writeoff-categories": "on",
    }
  end

end
