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
7. Run `rake db:migrate` to apply schema changes to databases
8. Configuration complete -- test by running `rails server` and viewing `localhost:3000` in browser

##Creating an AWS account 
1. Open https://aws.amazon.com/ 
2. Click "Create an AWS Account" in the top right corner
3. Type in your email or phone number and choose "I am a new user." 
   Afterwards, choose "Sign into our secure server"
4. On the Login Credentials screen, fill out the appropriate information for each box
   Click "create account" after completing.
5. On the Contact Information screen, fill out the appropriate information for each box. 
   Check the AWS Customer Agreement box afterwards and press "continue"
   (Check either if you're company or personal use)
**Make sure to choose the appropriate region


##Creating an EC2 Instance
1. Open https://aws.amazon.com/ and choose "Sign in to the Console"
2. Type in "EC2" under Amazon Services and click the first option
3. Click "Instances" under the Instances tab 
4. Click "Launch Instance"
   Step 1) Select the Ubuntu Server 16.04 option under the Amazon Machine Image (AMI)
   Step 2) Select the appropriate Instance Type for the application. 
   In this example, select t2.micro and click "Next: Configure Instance Details"
   Step 3) Configure Instance Details
   Leave the default options for "Next: Add Storage"
   Step 4) Leave the default option and click "Next: Add Tags"
   Step 5) Leave the default option and click "Next: Configure Security Group"
   Step 6) Assign the appropriate security group, create a new one if there are none to choose from. Click "Review and Launch" after completion
   Step 7) Review the information and hit "Launch" once everything is verified
   Select a keypair for the instance

