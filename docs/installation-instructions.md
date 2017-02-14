# Local Environment Setup

Steps for setting up a local dev environment.

## Windows 10
1. Install [Ruby 2.3.1 (32 bit) and the associated DevKit](http://rubyinstaller.org/downloads/).
2. Install Bundler via `gem install bundler`
3. Install Rails 5.0.0.1 via `gem install rails -v 5.0.0.1` (Rails is in Gemfile, so technically this step is included in (5); this step can also be done before (2), and Bundler will be installed as a dependency)
4. Clone the project locally with git; ensure it is up-to-date
5. Install any other dependencies with `bundle install` while in the pauselab/ directory containing Gemfile
6. Create local MySQL DBs that match the config/database.yml configuration. [XAMPP](https://www.apachefriends.org/index.html) can be used to create a MySQL server. Open `mysql` as root from shell and run the following:
    ```
    create database slp_pauselab character set utf8 collate utf8_general_ci;
    grant all on slp_pauselab.* to 'pauselab' identified by '<password>';
    grant all on slp_pauselab.* to 'pauselab'@'localhost' identified by '<password>';
    #repeat for database slp_pauselab_test
    ```
7. Run `rails db:migrate` to apply schema changes to databases
8. Create an application.yml with the appropriate keys for 3rd party APIs.
9. Configuration complete -- test by running `rails server` and viewing `localhost:3000` in browser
10. (Issue specific to my machine -- the `bcrypt` gem for MinGW is messed up, while the "normal" one is fine, so I uninstalled the former gem with `gem uninstall bcrypt` and then selecting `bcrypt-<version_number>-x86-mingw32` from the list of options. Unfortunately this gem reappears whenever `bundle install` is run, so find a way to automate this process or prevent it from happening.)

# Production environment setup

Steps for setting up a server meant for the deployed app.

## Creating an AWS account
1. Go to [Amazon Web Services (AWS)](https://aws.amazon.com/)
2. Click "Create an AWS Account" in the top right corner
3. Type in your email or phone number and choose "I am a new user." Afterwards, choose "Sign into our secure server"
4. On the Login Credentials screen, fill out the appropriate information for each box. Click "Create account" after completing.
5. On the Contact Information screen, fill out the appropriate information for each box. Check the AWS Customer Agreement box afterwards and press "Continue" (Check either if you're company or personal use) **Make sure to choose the appropriate region**

## Creating an EC2 Instance
1. Go to [AWS](https://aws.amazon.com/) and choose "Sign in to the Console"
2. Type in "EC2" under Amazon Services and click the first option
3. Click "Instances" under the Instances tab
4. Click "Launch Instance"
  1. Select the Ubuntu Server 16.04 option under the Amazon Machine Image (AMI)
  2. Select the appropriate Instance Type for the application. In this example, select t2.micro and click "Next: Configure Instance Details"
  3. Configure Instance Details. Leave the default options for "Next: Add Storage"
  4. Leave the default option and click "Next: Add Tags"
  5. Leave the default option and click "Next: Configure Security Group"
  6. Assign the appropriate security group, create a new one if there are none to choose from. Click "Review and Launch" after completion
  7. Review the information and hit "Launch" once everything is verified. Select a keypair for the instance. Distribute the private key to admin accounts that will be doing the next steps.

## Setting up the Rails App
1. Log into the Ubuntu EC2 instance with SSH. (`ssh` can be used from UNIX command lines, or with [putty](http://www.putty.org/) for Windows). Ensure the  RSA private key is with your client so you can connect.
  ```
  chmod 400 /path/to/private_key
  ssh -i /path/to/private_key username@hostname
  ```
2. The following instructions are adapted from the [RailsApps Project tutorial](http://railsapps.github.io/installrubyonrails-ubuntu.html). Update the package manager, install curl, git, MySQL client, Ruby Version Manager, Node Version Manager, Ruby and Node.js themselves, and the Bundler and Rails gems. The commands below will do all that (NOTE: your image may already have the first couple steps completed, but it doesn't hurt to repeat them).
  ```
  sudo apt-get update
  sudo apt-get install curl git mysql-client libmysqlclient-dev
  curl -L https://get.rvm.io | bash -s stable --ruby
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  ```
At this point, it is worth reloading bash's environment variables by logging out and back into the instance (`logout` and repeat `ssh`). This ensures `rvm` and `nvm` are on the PATH before continuing.
  ```
  rvm install 2.3.1 && rvm use 2.3.1
  nvm install node && nvm use node
  gem update --system
  gem install bundler
  gem install rails -v 5.0.0.1
  ```
3. Upload project files to the server. If using git, then clone the repository. Otherwise use `scp` or `rsync` to transfer your local files to the server.
  ```
  git clone https://github.com/uva-slp/pauselab.git
  ```
If the project is private on GitHub, then credentials of a collaborator will need to be provided.
4. Install all the necessary gems listed in the Gemfile.
  ```
  cd pauselab/app
  rvm 2.3.1
  bundle install --deployment --without development test
  ```
5. Setup and deploy a MySQL server (adapted from [Digital Ocean tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04)). The first step will download a package and prompt you to create a password for the root user -- make a secure one and remember it! The second step will disable some unsafe features of MySQL -- enter "yes" for all the options except changing root's password, which you just did.
  ```
  sudo apt-get install mysql-server
  sudo mysql_secure_installation
  ```
Once that's done, open the MySQL shell as root with the command `mysql -u root -p` -- once in the shell, execute the following commands (in place of `<password>` make an actual password for the Pauselab database. It need not be the same password as MySQL root).
  ```
  create database pauselab_production character set utf8 collate utf8_general_ci;
  grant all on pauselab_production.* to 'pauselab' identified by '<password>';
  grant all on pauselab_production.* to 'pauselab'@'localhost' identified by '<password>';
  exit;
  ```
6. Setup and deploy the web server (adapted from [GoRails tutorial](https://gorails.com/deploy/ubuntu/16.04)). Install Nginx and start the service with the following commands.
  ```
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
  sudo apt-get install -y apt-transport-https ca-certificates
  sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
  sudo apt-get update
  sudo apt-get install -y nginx-extras passenger
  sudo service nginx start
  ```
Then update some configuration files. TODO finish (currently having issues).
7. Setup Capistrano? (probably not needed)
8. Create a file in config/ called application.yml and fill it with all the secrets, passwords, and 3rd party API keys needed to run the app. Below is a how the YAML file should look, where the values in `<angle brackets>` should be replaced with what is described within.
```
production:
  GROUP_PWD: <password made for 'pauselab' MySQL user in step 5>
  EMAIL_USER: <email address used for mailing from within the app>
  EMAIL_PASS: <password for EMAIL_USER>
  DEVISE_SECRET_KEY: <secret generated from `rails secret`>
  SECRET_KEY_BASE: <another secret generated from `rails secret`>
  GOOGLE_API_KEY: <provided by Google for Maps API>
  RECAPTCHA_SITE_KEY: <provided by Google for recaptcha>
  RECAPTCHA_SECRET_KEY: <provided by Google for recaptcha>
```
9. Migrate database changes to update the schema, and compile rails assets. Run the following commands from bash.
```
  rails db:migrate RAILS_ENV=production
  rails assets:precompile RAILS_ENV=production
```
10. Touch tmp/restart.txt (i.e. `touch tmp/restart.txt`) and the app should be live.
