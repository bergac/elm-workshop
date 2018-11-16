# elm-workshop

Updated to Elm v0.19.0!

This repository contains some exercises to work with Elm. Some exercises are
an extension of an Elm Architecture tutorial (recommended to do these as well,
see https://guide.elm-lang.org/architecture/).

You could use Ellie-app (https://ellie-app.com) to write, compile and format the
code. Ellie-app doesn’t work optimal if you’re browsing in incognito modus.
If you want to save your work, click on Save in Ellies UI and save the URL
somewhere. If you already have Elm installed, and know how to develop using
`elm reactor` or `elm make`, feel free to do the assignments on your own machine.  

Be aware that Elm provides extensive documentation! Useful links are provided
for some of the assignments.  
The official Elm guide: https://guide.elm-lang.org/  
The official Elm syntax guide: https://elm-lang.org/docs/syntax  

Good luck!

## How to run the demo's?
* Use the online editor [Ellie App](https://ellie-app.com) (recommended). Every
Elm exercise file should have an URL to Ellie. The workshop in Ellie App is the
same as in the file. I did not add any styling though.
* If Elm is installed, run `elm-reactor` in the root directory of this project
and go to http://localhost:8000.

## Ellie App URLs
| Exercise | URL |
|---|---|
| Counter | https://ellie-app.com/3TYpYLPqYsra1 |
| Reverse | https://ellie-app.com/3TYtY3bjfJGa1 |
| Gravatar / Http | https://ellie-app.com/3TYPbHKcKvLa1 |

## Assignment 1 - Counter
Go to https://ellie-app.com/3TYpYLPqYsra1 and click on ‘compile’.
The app consists of a simple counter, and 2 buttons which either increment or
decrement the count. Implement the following features (see TODOs in the code):
* Create a reset button, which should reset the counter to 0 when it’s clicked.
* If the counter is 0, prevent it from going below 0.
* Bonus: create another case for the counter (i.e. add another button which adds
  2 when it’s clicked, or calculates the square).

## Assignment 2 - Reverse strings
Go to https://ellie-app.com/3TYtY3bjfJGa1 and click on ‘compile’. Type a random
string in the input field. As you can see, the reversed string of what you have
written in the input field is shown. Implement the following features:
* Every time the user loses the focus of the field (i.e. an ‘onBlur’ event), the
text in the input field should be saved to the state (for example add the text
  to a List in model).
* Every saved text item should be shown below “list of strings go down here”.
The code already contains methods to show a List in HTML (toHtmlList and toLi).
Use these to show the saved items.
* Bonus: remember the total number of subjects, by using the counter in the
model.

The code contains 7 TODOs (excluding the bonus), which help you to implement
these features.

## Assignment 3 - Show user profiles from Gravatar (HTTP)
Go to https://ellie-app.com/3TYPbHKcKvLa1 and click on ‘compile’. You can see a
few things:
- An input field;
- A button with ‘Add User’;
- An icon (Gravatar icon), which shows the image of the email address in the
input field real-time;
- 2 block elements with mentor details.
Fill ‘MyEmailAddress@example.com’ in the input field. The corresponding icon is
shown. The ‘Add User button doesn’t do anything yet. You are going to add some
features to this app, so that you can add users and show some details about
them. If you also like to add yourself, you can create a profile at
https://www.gravatar.com if you haven’t done that already.

With Gravatar you can link a profile picture (avatar) to your email address.
Many website use Gravatar, such as StackOverflow or GitHub. After completing all
the TODOs (14 in total), the app should:
* make an HTTP GET request to Gravatar when the ‘Add User button is clicked for
the email address that’s in the input field
* should parse the response from Gravatar and extract some fields to show in the
view (response example: https://en.gravatar.com/5b539801779e61e89ae25afccf0069ff.json)
* should save every added user to a list of users
* should show the list of users with details
Note: the TODOs are scattered through the code. Make sure you implement them in
the right order (14 in total).
