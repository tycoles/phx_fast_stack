rm -rf assets/node_modules/* deps/* && 
mix deps.get && 
npm install --prefix assets && 
mix ecto.setup