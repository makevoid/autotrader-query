module Config
  MAX_PRICE = 18_000 # 18k upper limit, but ideally < 15k
  # MAX_PRICE = 100_000 # infinity (at least for me) # debug only - TODO: delete this line

  def default_params
    {
      # cheapest car with openpilot in UK

      # make: "HONDA",
      # # # model: "CIVIC",
      # model: "CR-V",

      # make: "HYUNDAI",
      # "body-type": "SUV", # tucson really :D

      # make: "TOYOTA",
      # model: "C-HR",

      make: "TOYOTA",
      model: "PRIUS",

      # not many corollas around here
      #
      # make: "TOYOTA",
      # model: "COROLLA",

      # make: "TOYOTA",
      # model: "AURIS",

      # make: "KIA",
      # "body-type": "SUV",

      # make: "KIA",
      # model: "SORENTO",

      # make: "TOYOTA",
      # model: "PRIUS",

      # model: "COROLLA",

      "year-from": 2015,

      # radius: 100, # national
      radius: 15,
      postcode: "E14 3RS",
      transmission: "Automatic",

      # unused options:
      #
      # onesearchad: "Used",
      # "writeoff-categories": "on",
    }
  end

end
