Notes on steps for setting up a local dev environment.

#Windows 10
1. Install [Ruby 2.3.1 (32 bit) and the associated DevKit](http://rubyinstaller.org/downloads/).
2. Install Bundler via `gem install bundler`
3. Install Rails 5.0.0.1 via `gem install rails -v 5.0.0.1` (Rails is in Gemfile, so technically this step is included in (5); this step can also be done before (2), and Bundler will be installed as a dependency)
4. Clone the project locally with git; ensure it is up-to-date
5. Install any other dependencies with `bundle install` while in the pauselab/ directory containing Gemfile
6. Create local MySQL DBs that match the config/database.yml configuration. [XAMPP](https://www.apachefriends.org/index.html) can be used to create a MySQL server. Open `mysql` from shell and run the following:
```

```
7. Run `rake db:migrate` to apply changes to databases.
