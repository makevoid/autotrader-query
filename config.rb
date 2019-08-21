module Config
  MAX_PRICE = 16_000 # my budget for PRIUS
  # MAX_PRICE = 100_000 # infinity (at least for me) 

  def default_params
    {
      # cheapest car with openpilot in UK

      make: "TOYOTA",
      model: "PRIUS",

      # make: "HONDA",
      # model: "CIVIC",

      # make: "HONDA",
      # model: "CR-V",

      # make: "HYUNDAI",
      # "body-type": "SUV", # tucson really :D

      # colour: "White",

      "year-from": 2016,

      radius: 20,
      # radius: 15,
      # radius: 100, # national

      postcode: "E14 3RS",
      transmission: "Automatic",

      # "seller-type": "trade",

      # unused options:
      #
      # onesearchad: "Used",
      # "writeoff-categories": "on",
    }
  end

end
