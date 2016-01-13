# Donegood

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Note you'll need environment variables for `FACEBOOK_CLIENT_ID`, `FACEBOOK_CLIENT_SECRET`, `TWITTER_CONSUMER_KEY` and `TWITTER_CONSUMER_SECRET`

Now you can visit [`localhost:4015`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## What I did
### Installing Phoenix globally
```
mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v1.1.1/phoenix_new-1.1.1.ez
```
Found the .ez file link on [this page](https://github.com/phoenixframework/phoenix/releases).

### Adding JS libraries (via Brunch):
```
npm install --save react # goes into dependencies in package.json
npm install --save-dev react-coffee-brunch
```
Although that ended up breaking things so I reverted it.

### Adding a User model (and scaffolding)
```
mix phoenix.gen.html User users name:string email:string bio:string number_of_pets:integer
```

### Adding a Deed JSON model
Use `mix phoenix.gen.json`, including `user_id:references:users` for the relationship and adding `has_many :deeds, Donegood.Deed` to the `User` model

### Inserting data
Ran the server with `iex -S mix phoenix.server`
```
alias Donegood.Deed
alias Donegood.Repo

params = %{ title: "Helped someone move", body: "Had to go across town in the rain", duration: 14400, user_id: 1 }
changeset = Deed.changeset(%Deed{}, params)
Repo.insert changeset
```

### Adding JS stuff
Added coffeescript support in `package.json` with
```
 "coffee-script-brunch": ">= 1.8",
 ```
and then `npm install`. Can add these with
```
npm install --save react-coffee-brunch
```
Added
```
      presets: ['es2015', 'react'],
```
to `brunch-config.js` to get jsx templating in `app.js`, having done
```
npm install babel-preset-react --save
```

Also had to `npm install react-dom` and then add `react` and `react-dom` to the `whitelist`

### Adding authentication
Found Ueberauth / Guardian - looked at [this project ](https://github.com/wafcio/screencast_aggregator) to see how to install it

### Adding additional migrations
```
mix ecto.gen.migration add_ueberauth_fields
```

### Adding API explicitly
Moved `wellbeing` api into `/api`. Didn't have to explicitly declare `Donegood.Api.` namespace thankfully. 

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
