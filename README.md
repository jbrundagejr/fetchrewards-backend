# README

This Rails API uses Ruby 2.6.1. For documentation on installing Ruby locally, visit https://www.ruby-lang.org/en/documentation/installation/. It also uses a PostGreSQL database. To install PostGreSQL locally, visit https://postgresapp.com/ on a mac or https://www.postgresql.org/download/windows/ for a PC and make sure it is running before creating the database.

Once Ruby is installed, fork and clone this repository. Then cd into the repository and run the command `bundle install`. To get the database and server up, run the following commands:

  `rails db:create`
  `rails db:migrate`
  `rails db:seed`
  `rails s`
  
If you navigate to http://localhost:3000, you should now see that you are running on Rails.

This API has three fetch end points as described below.

POST to http://localhost:3000/transactions
  -Headers: {Content-type: "application/json"}
  -Body: {"points": integer, "payer_id": integer}
  -Return:
      {
        "points": integer(value passed in fetch),
        "created_at": timestamp,
        "payer": {
            "name": string,
            "points": integer(updated point balance)
            }
      }   
        
PATCH to http://localhost:3000/spend
  -Headers: {Content-type: "application/json"}
  -Body: {"points": int}
  -Return:
     [
       {
         "payer": string,
         "points": integer
        }
      ]
      
GET to http://localhost:3000/pointbalances
  -Return: 
    {
      "payer.name": integer(point balance)
    }
