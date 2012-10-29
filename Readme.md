# Translate Routes extension for Refinery CMS.

This Refinery CMS engine aims to translate routes of the Refinery engines (blog, calendar... ) based on the [rails-translate-routes gem](https://rubygems.org/gems/rails-translate-routes).

However, rails-translate-routes gem doesn't work without modification in a Rails application with engines (at least on a Refinery app) so this engine tries to encapsulate the needed modifications.

## How to install

Right now we don't have a real gem and we're including it in our gemfiles with a line like

```
gem 'refinerycms-translate_routes', :git => "git://github.com/the-cocktail/refinerycms-translate-routes.git", :tag => "original"
```

## How to use it

You just have to include a file at config/locale/routes.yml with the format explained in the [rails-tranlate-routes repo](https://github.com/francesc/rails-translate-routes#basic-usage).

In fact, if no config/locale/route.yml is created you will have some errors in your app.

## Known Bugs

Issue #1: _url helpers don't work properly
Issue #2: some admin routes are getting translated while other don't

## Wishlist

1. Bug fixing
2. Bug fixing
3. Even more Bug fixing
4. Creating a gem
5. Creating a system to make it easier to test this engine in your app