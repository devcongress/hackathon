# Configure plutonium

Plutonium.configure do |config|
  config.load_defaults 1.0

  config.assets.stylesheet = "application"
  config.assets.script = "application"
  config.assets.logo = "icon_256.png"
  config.assets.favicon = "favicon.ico"
  # Configure plutonium above.
end
