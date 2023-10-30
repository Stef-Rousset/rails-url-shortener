# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# MY SHARED TOOLS

### Introduction ###

The purpose of this application is to allow users to access different tools .

With this application, you will mainly be able to:
- generate shorter urls,
- get selected news feed in your mail every day,
- get the weather forecast in youy mail every day for your city.


### Prerequisites ###

Make sure these tools are installed on your machine:
- ruby version "3.2.1" => the coding language [https://www.ruby-lang.org/fr/]
- git => an open source version control system [https://git-scm.com/]

You will also need:
- a relational database => the project uses postgreSQL [https://www.postgresql.org/], but you can use another relational database (see below).

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
- If you want to get access to the different tools, you will need to signin with your email and password

### Application endpoints ###

The main endpoints are :

For the url-shortener and current_user:
- Get all urls<br>
GET `/short_urls/index`
- Create a new short url<br>
GET `/short_urls/new`<br>
- Show long url and its corresponding tiny url<br>
GET `/short_urls/:id`<br>
- Use of the tiny url, to be redirected to long_url <br>
GET `/:url_shortened`<br>

For the news feed and current_user:
- First selection of sources <br>
GET `/choose_sources`
- Modify selection of sources <br>
GET `/edit_sources_for_user`

For the weather forecast and current_user:
*under construction* <br>

### Testing ###

Testing is performed with Rspec, using FactoryBot.

- testing the models =>
`rspec spec/models`
- testing the controllers =>
`rspec spec/controllers`

