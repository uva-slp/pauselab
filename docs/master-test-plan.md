# Introduction

## Document Identifier

The Master Test Plan (MTP) is to define the resources and schedule necessary to complete a comprehensive testing of PauseLab’s BeCville web application.  The MTP also specifies how and which features will be tested to produce a working system that meets all requirements.

# System Overview

BeCville is a web application conceived by the Charlottesville non-profit PauseLab.  The purpose of BeCville is to implement participatory budgeting online for residents in specific neighborhoods in Charlottesville.  The system was created with the Rails framework, using open sourced gems.

## Key Features

To implement a participatory budgeting system, the application must be able to let residents submit their ideas on improving the community, let residents view, like and share each other’s ideas, let privileged users create and view proposals, allow residents be able to vote on proposals, and allow site administrators be able to monitor the website.

# Test Overview

Not only will we test the functionality and requirements of the system, but other non-functional tests such as usability, reliability, performance, supportability, compatibility, installation and security. These tests will include testing of the MVC components and their functions, having a variety of users testing the system, testing the system on different platforms, and starting up the system from a new machine. For functionality and requirements testing we will map each requirement to at least one test to assure all requirements are fulfilled and functional.

## Resources and tools

We will use be using RSpec as our main provider for unit and functionality tests. RSpec is a tool for Rails that allows for unit testing of many MVC components. We will also be using SimpleCov as a way to track the code coverage of only the code developed for BeCville, and not the gems used. For continuous integration we have been using Travis-CI, which connects to our repository and runs the RSpec tests for every push making sure the collaborated work never fails.  To test the JavaScript in the system we will be using QUnit as the framework, blanket.js for JavaScript code coverage, and PhantomJS to automate the tests.  To test the the views we will be using Capybara, which is a Rails based acceptance test for views.

## Details of Master Test Plan

We will adhere to the following test process to guarantee all functional and nonfunctional requirements are fulfilled.

Each requirement will be mapped to at least one, if not many, test cases using RSpec.  The test cases will not only use factories that should produce a correct outcome, but use factories that don’t match the desired input.  This way the tests take into account when a user incorrectly uses the system.  The unit test names, as well as a single comment per test, will describe what the test is testing and which requirement it maps to.

Rails is an MVC framework meaning there are many different components that we will test.  Specifically for the BeCville system we will test the models, views and controllers for ideas, proposals, users, blogs, votes, pages, landing pages, categories, phases, and comments among others.  For most of the components the controller normally has a “new”, “create”, “index”, “update”, and “delete” methods.  Each have different requirements and validations.  Each will be tested with correct and incorrect inputs.  Many of the components also have object specific methods in the controller and models which will also be tested.  An example is how the idea controller also has a “like” functionality which will be tested. Further many of these components can only be seen, edited or approved based on a user’s role and privileges.  The created tests will account for different users attempting different things to assure correctness.  During development all group members have continuously created unit test testing the system.  As development continues and comes to an end each group member will continue to create unit test that push for code coverage, and multiple test corner cases.

As mentioned above some of the unit tests will check to make sure only privileged users can access privileged components and URLs.  We will also physically try to access privileged components as unprivileged users to make sure the error catching is natural and doesn’t break the system. Oscar Sandoval and Sudipta Quabili will write these tests.

To test the usability of the system we will create tests and tasks to be performed by a variety of different users with different comfort levels with computers.  There are many different user types for the BeCville system, so it is important to get a varying background of users. The client and the rest of the PauseLab team have different familiarity with the system, so each will be tested.  Part of the system requires that residents use the system, meaning there will be many first time users.  We will test certain actions to new users with little instruction to see how useable the system is.  Sugat Poudel and Henry Garrett will write these tasks for test subjects to perform.   

For installation testing we will get unfamiliar users to follow the installation manual on a new machine to assure the system can clearly be installed as well as make sure the documentation is thorough.  Once the installation is complete the RSpec test cases will be run to make sure the system is correctly installed.  Amir Gurung and Jay Sebastian will be in charge of creating the installation instructions.

We will execute the requirements test on the most recent version of the major web browsers (Firefox, Chrome, IE, and Safari). If -- and only if -- the requirements test passes on all of those browsers, then the compatibility test will be considered to have passed.   

## Schedule

The process of writing unit tests towards code coverage will continue until deployment.  By April 10nth we will have 100% core code coverage, 75% JavaScript code coverage, full installation test plan, usability test plan, security test plan, requirements test plan, and compatibility test plan.  By April 24th every test plan will be performed and reported on the destination server.
