if ENV["CIRCULATE_SIGNUP"]
  Dotenv.require_keys("SQUARE_ACCESS_TOKEN", "SQUARE_LOCATION_ID")
end
