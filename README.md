# Time2

# Design 
Database contain one User table for all user that includes 2 user groups: 1. worker, 2. manager. 

In the single page application, the user need to login in order to perform actions such as submit timesheet. If user didn't login, submitting a timesheet would return unprocessable_entity error. 

Worker can only create timesheet.
Option to view timesheet setup yet and approve timesheet not set up yet.

Login infos:  
Worker: bob@example.com password:1    
Worker: carol@example.com password:1  
Worker: dave@example.com password:1  
Manager: alice@example.com password: 1
Manager: test password: 1   


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
