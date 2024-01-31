# Pre-requisites

- docker & docker compose

# Running app
```
$ docker compose up
```

# Setting up the application

- Get the CONTAINER_ID
```
$ docker ps
```

## Set up the database
- Run the following command:

```
$ docker exec -it <CONTAINER_ID> rails db:prepare
```

or

```
$ docker exec -it <CONTAINER_ID> rails db:create
$ docker exec -it <CONTAINER_ID> rails db:migrate
$ docker exec -it <CONTAINER_ID> rails db:seed
```

Your server will be running on http://localhost:3000

# Sending requests

## Console

You can send requests with following commands:

```
$ curl -X POST -d '{"plate": "aaA-4444"}' -H 'Content-type: application/json', http://localhost:3000/parking # to create parking

$ curl -X PUT http://localhost:3000/parking/aAa-4444/pay # to pay the parking

$ curl -X PUT http://localhost:3000/parking/aAa-4444/out # to leave the parking

```

## Postman

You can also export the file `parking_lot_control.postman_collection.json` on Postman and see all requests if you want to.

Happy conding! :)