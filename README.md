# Mr Robot

Minimalist command line application built with ruby, using Thor for interface and params management. Tests are written using Rspec.

## Instalation
- Make sure you are using ruby 3.2.2, e.g ```rbenv local 3.2.2```
- Clone the repo and ```cd``` to it
- Run: ```bundle install```
- Play with it! Try typing ```bundle exec thor list``` to see the list of available commands with examples and params usage

## About the app
- Main App or "entry point" is ```app.thor```. In it, you'll find the commands that compose the application: ```interactive``` and ```import```.
- Interactive runs the app on a loop that can be exited by typing ```exit``` or just by ```ctrl-c```
    - ```bundle exec thor app:interactive``` will run the app and ask for a valid command
    - If an invalid command is passed, you should see an error message (```Invalid command```)
    - The input is case insensitive, e.g ```MoVe``` is a valid command.
- Import takes a file path as an argument and reads the commands line by line.
    - ```bundle exec thor app:import spec/fixtures/commands.txt``` parse the commands and output the reports
    - If no file is found a ```Looks like you entered an invalid file``` message should be displayed

## Run the tests
Just type ```bundle exec rspec``` to run all tests.

## TODO
- Not happy with the test for the .thor file, but it's how some of the tests are done in their repo: https://github.com/rails/thor/blob/a43d92fad7ebd77d359b7b96eb3db8a73ef9057c/spec/shell/basic_spec.rb#L48. It works?! but there's got to be a better way, maybe Cucumber?
- Docker to test it easier
- Configure some CI to run checks to prevent mergig when build is failing
- Certainly, so much more that can be done xD!

## Final thoughts
Feel free to test with multiple files and play with the app!
