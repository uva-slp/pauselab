# Specific Test Plans

## Installation Testing

We will assure that the system is correctly installed and fully functional on the customer’s server by beginning stepping through Installation Instructions, running the unit tests on the server, then performing certain tasks.  To start we will create an EC2 instance on Amazon Web Services with the correct settings.  From there, follow the rest of the installation instructions on installing Rails, the PauseLab app, and MySql. 
	Once the site is up and running check for functionality of core features.
1. Check that a user can successfully be created and ReCaptcha correctly works.
2. As an admin submit and idea, check to see if it saves, and check to see that Google Maps registered the idea’s location.
3. Check that phase and iteration transition properly. 
    * In the ideas collection phase create a few users and approved ideas, then change phase to proposals.  
    *	Make and approve a few proposals, then change phase to voting.
    *	As a resident user, vote on projects, try again to assure residents can’t vote twice.  
    *	Lastly, as an admin end the iteration.  Check to see if the iteration’s data is correctly zipped and exported. Check that data is reset for residents, and the phase goes back to ideas collection.

These tests will assure the site is correctly installed and functional on the deployment server.


## Results
I could correctly follow the instruction from the installation plan, and all the functionality of the system worked correctly. A few notes I took on the instruction.
1. Setting Up RailsApp, Part 2: At first i didn't log out and log in, and rvm and nvm weren't found.  After logging back in it worked fine.
2. Part 5. I think it would be helpful to say these lines are located around line 60
3. Part5.3. The easiest way to do this step is comment out all of the exsisting code, then edit/add the correct code.
4. Part 7. I might have made a slight mistake when I once called "bundle install" instead of "bundle install --deployment --without development test" which I guess changed the default bundler.  Before calling any rails commands i had to recall "rvm 2.3.1" then "bundle install --deployment --without development test", and everything worked fine. 


## Usability Tests
PauseLab needs to be usable, comfortable and intuitive.  To test this assign various user roles to unfamiliar test users, give them tasks to complete, then talk to them how intuitive or difficult the task was.  Ask about how overall navigation of the website feels. Usability is user feedback generated.  Once given feedback, make any necessary changes, and perform similar tasks on a new unfamiliar group of test users.  The unfamiliar users in this case will be interns and employees of PauseLab and friends with varying levels of web development knowledge.
	The following are the various roles users should be assigned.  Before the users are tested they should be aware or told what participatory budgeting is, and the goal of the tasks they are performing.  Depending on the role and the task for the user, some ideas and proposals should be created before performing the tests.  Further many pages, such as user homepages, have editable posts that are supposed to give some instruction on how to navigate the site.  To simulate an actual situation, the test giver should make sure those posts are edited to reflect what a user would see.  It is easier to perform tests when test giver is logged in as admin on different machine to easier change phase.  
	
1. Residents
    * Create an idea
    * View all ideas, sort
    * Share an idea on Facebook
    * View a blog
    * Submit a vote
  
2. Artists
    * Create an account
    * View ideas, and sort by most likes
    * Create a proposal

3. Super Artist
    *	Create a blog post

4.	Steering Committee Member
    *	View all proposals
    *	Comment on proposal
    *	View votes

5. Moderator
    * Approve, delete, create, edit ideas
    * Approve, delete, create, edit proposals
    * Comment on an idea and proposal
    * Change the phase
    * Views proposals, and sort by most votes
    * Submit a paper idea, vote

6.	Admin: Perform same tests as moderator plus the following tests
    * Change a user’s role 
    * Edit Home Page, user role homepages, About Us
    * Create, edit a blog post
    
On top of specific user tests, let the test user play around with the system.  Ask for feedback about what is easy and what was difficult or confusing. If the subject says something is difficult follow up with questions on why it was difficult, and what would make it easier.  Document the feedback, and consider any necessary design changes.

## Security Testing

  PauseLab is responsible for allocating public money, so there is a lot on the line for security of the system. No money is exchanged on the site, but the decision making behind where it goes is.  This means the system must prevent voter fraud, and unprivileged users performing or viewing privileged actions and content.

   Security features like ReCaptcha, Admin vote oversite, and the Rails framework will prevent of computer attempts to vote multiple times and voter fraud.

  We have a series of unit tests where unprivileged users try to perform tasks they shouldn’t.  The unit tests are expected to fail, and give flash errors.  These tests are performed on all major models we have in the system.  We will also log in as low privileged users, and try to type in certain URLs that should be inaccessible, such as admin’s voting and user consoles.  We will test that the system not only blocks the attempt, but also handles it in a reasonable manner. 

  We will also test how the system handles invalid or malformed inputs in a reasonable way.  Attempting to go to an invalid URL gives sensible feedback and navigation.

## Requirements Testing
Our team and PauseLab have come up with a set of requirements for their desired system.  Each requirement will be mapped to at least one, if not many unit tests using RSpec. This way the tests take into account when a user incorrectly uses the system.  The unit test names, as well as a single comment per test, will describe what the test is testing and which requirement it maps to.  

## Compatibility Testing
We will execute the requirements test on the most recent version of the major web browsers (Firefox, Chrome, IE, and Safari). If -- and only if -- the requirements test passes on all of those browsers, then the compatibility test will be considered to have passed.   

### Results
The system runs correctly on Microsoft Edge and iOS devices. The system fullfills all given requirements on Firefox, Chrome, Safari and android devices. 

