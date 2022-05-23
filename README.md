# README

This project is a submission for the Shopify Fall 2022 Backend Developer Challenge. This project is inmplemented in Ruby and Ruby on Rails framework 

* Language - ```Ruby```

* Web Framework - ```Ruby on Rails```

* Database - ```SQLite3```

* Ruby version - ```3.1.2```

* Rails version - ```7.0.3```


## Steps to Get the application running:
	
Step 1: Database creation - ```rake db:migrate```

Step 2: Database initialization - ```rake db:seed```

Step 3: Start the rails server - ```rails s -p 3000```

Step 4: Type in ```127.0.0.1:3000``` or ```localhost:3000``` in the browser. This is the homepage for the application

## Features Implemented:

### Inventory CRUD

Inventory CRUD - Click on ```Inventories``` on home page options and follow the on-screen options

### Additional Task Implemented:

Ability to create shipments and assign inventory to shipment and adjust inventory appropriately

1. Click on ```Shipments``` on home page options and follow the on-screen options to create a shipment

2. Click on ```Assign Inventory``` on a single shipment member and follow the on-screen options to assign inventory to a shipment.

3. Click on ```Remove``` button right next to an assigned inventory to a shipment in order to remove it from the shipment.
