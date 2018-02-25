# Store Space Management - API


APIs for Store Space Management
Author: @keerthijk
Authored on: Feb 24 2018

### Installation

Store Space Management requires Ruby version 2.4.0p0 to run.

Other dependencies
- Install Docker Engine – Ref: https://docs.docker.com/engine/installation/

- Install Docker Compose – Ref: https://docs.docker.com/v1.8/compose/install/


### Configuration

```
cd storespace
docker-compose build
```

### Create database and run migrations

```
docker-compose run app rake db:create db:migrate
```

### Run the test suite
```
docker-compose run -e "RAILS_ENV=test" app rspec
```

### Start server
```
docker-compose up
```

### Sample APIs to run
To create Store
```
POST http://localhost:3000/stores
pass json in body ex:
{
	"store": {
		"title": "new store",
		"city": "Thrissur",
		"street": "abc",
	}
}
```
To update store
```
PATCH http://localhost:3000/stores/:display_id
pass json in body ex:
{
	"store": {
		"title": "another title",
		"city": "Thrissur",
		"street": "abc",
	}
}
```
To show store
```
GET http://localhost:3000/stores/:display_id
```
To search stores
```
GET http://localhost:3000/stores?{attribute}={operation}:{value}
replace {attribute} as title or city or street or spaces_count
replace {operation} as like or eq or gt or lt
replace {value} as any search value
```

To delete store
```
DELETE http://localhost:3000/stores/:display_id
```

To calculate price of space
```
GET http://localhost:3000/spaces/:display_id/price/:start_date/:end_date
ex: start_date as 1-1-2018
    end_date as 30-1-2018
```
