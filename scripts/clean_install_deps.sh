rm -rf assets/node_modules/* deps/* && 
npm install --prefix assets && 
mix deps.get && 
mix ecto.setup