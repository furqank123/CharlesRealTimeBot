# CharlesRealTimeBot

### Overview 

This bot was designed to complete a set of specific routines through Slack. At its core the bot itself interacts with the user(s) 
whilst listening to anything that may cause a trigger, this is achieved by utilizing WebSocket & Slack Real 
Time Messaging APIs. These two are bundled in a very neat fashion in a library called [slack-ruby-client](https://github.com/slack-ruby/slack-ruby-client) alongside most of the slack APIs.
This library also handles concurrency internally using lightweight concurrency libraries, async is being used in our project which
is built on top of Celluloid::IO.

### Purpose

The main job of this robot is to listen to events that concern itself. Once an event concerning itself is triggered, the robot 
will ask certain queries which will eventually lead to executing a Charles proxy session based on the application and platform demanded
by the user. Once the execution is complete the user is then presented with a Charles session log in the channel the event was triggered.
 
### Execution 

Before we begin there are a few things that are required:

* Ruby - brew install ruby 
* Bundler - gem install bundler
* appium Server - npm install -g appium
* Charles Proxy - Add Charles' path to your .bash_profile
* Create a bot in slack and set the bot's oAuth token as environment variable: SLACK_API_TOKEN
* Line:41 of charlesbot.rb update the directory up to session.chls to wherever you will be cloning this project

Let's begin:

Start Charles and stop recording, run appium through terminal. To start the server execute the following:
- *bundle* - this will download all the dependencies required
- *bundle exec ruby charlesbot.rb* - This will spin up a server in the background and retain its connectivity through WebSocket

If everything went smoothly the robot should be ready to use in any channel that it is part of and private messages.

List of commands:
- charles hi
- charles execute


When charles execute command is executed the bot this will trigger a chain of events and user can now
have a fluid "conversation" with the bot as it will ask and answer a few queries please see below sample. All responses
user provides are case sensitive, hence the reply must be typed as provided. See below for an example:

<img width="770" alt="screenshot 2019-01-21 10 14 04" src="https://user-images.githubusercontent.com/24193787/51485432-0ccdd400-1d6c-11e9-9fa2-a3d44f0b098e.png">
