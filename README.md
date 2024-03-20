# README

# MY SHARED TOOLS

### Introduction ###

The purpose of this application is to allow users to access different tools.

With this application, you will mainly be able to:
- generate shorter urls,
- get selected news feed in your mailbox every day,
- get the weather forecast for any city,
- check the spell of a word,
- manage personal finance.


### Prerequisites ###

Make sure these tools are installed on your machine:
- ruby version "3.2.1" => the coding language [https://www.ruby-lang.org/fr/]
- git => an open source version control system [https://git-scm.com/]

You will also need:
- a relational database => the project uses postgreSQL [https://www.postgresql.org/], but you can use another relational database (see below).
- an account in OpenAI with an api key, to be able to use the spell checker tool.

### Installation ###

- Clone this repository => replace `my project_name` with the name you choose for your app
`git clone git@github.com:Stef-Rousset/rails-url-shortener.git my_project_name`
- Move into the project you created =>
`cd my_project_name`
- If you want to change the db for mySQL for example =>
 `rails db:system:change --to=mysql`
- Install dependencies =>
`bundle install`
- Initialize the database =>
`rails db:create db:migrate db:seed`
- You can launch the server with `bin/dev`.<br>
The server should only run on `localhost:3000`.<br>
You should see the homepage of the application.
If you want to stop the server, use Ctrl + C.<br>
- Add your OpenAI api key in Rails credentials with a key named `openai_api_key`
- If you want to get access to the different tools, you will need to sign in with your email and password


### Application endpoints ###

The main endpoints are :

For the url-shortener :
- Get all urls<br>
GET `/short_urls/index`
- Create a new short url<br>
GET `/short_urls/new`<br>
- Show long url and its corresponding tiny url<br>
GET `/short_urls/:id`<br>
- Use of the tiny url, to be redirected to long_url <br>
GET `/:url_shortened`<br>

For the news feed :
- First selection of sources <br>
GET `/sources`
- Modify selection of sources <br>
GET `/edit_sources_for_user`

For the weather forecast :
- Get the weather forecast for a city <br>
GET `/weather`

For the spell checker :
- Get the correct spell for a word <br>
GET `/spell_checker`

For the personal finance handler :
- Get list of accounts <br>
GET `/accounts`
- Create a new account <br>
GET `/accounts/new`
- Show an account, and handle its transactions<br>
GET `/accounts/:id`
- See planned transactions<br>
GET `/planned_transactions`

### Testing ###

Testing is performed with Rspec, using FactoryBot.

- testing the models =>
`rspec spec/models`
- testing the controllers =>
`rspec spec/controllers`
- testing policies =>
`rspec spec/policies`
- testing mailers =>
`rspec spec/mailers`
- testing jobs =>
`rspec spec/jobs`
- testing services =>
`rspec spec/services`
- testing system =>
`rspec spec/system`
