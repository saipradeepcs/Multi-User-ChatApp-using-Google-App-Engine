PROJECT - chatapp using Google App Engine
===========================================

This is a repository to share code regarding the project.

Project Owner:
==============
Chokka Sudarsan, Sai Pradeep - M08650972

URL:
====
http://1-dot-eastern-store-123204.appspot.com/myapp

NOTE:
_____
Built using Java Google app engine sdk on Google App engine

SERVICES USED: 
==============
1. Google user authentication : Authenticates only google users
2. Google channel api : for sending messages 
3. memcache : to store chat history; will be used for showing history to users who logged in later
4. Google drive picker api : to select and load files from google drive
5. Google docs viewer api : to view any format docs

Multi chat application with document sharing (for viewing purpose only)
=======================================================================
Any number of users can login and chat with each other
User Roles: 
___________
admin and normal user
Admin User: 
___________
admin user can select a file from his google drive and share file with other users in chat.
only admin can start document sharing.(to test this use below login details)

test login id: jamie.rod599@gmail.com (has admin role)

test login pwd: italianjob2

EXAMPLE USAGE:
______________

1. Enter the Admin test login id: jamie.rod599@gmail.com (has admin role) and password: italianjob2, this step uses Google user authentication API.
2. Select any file from the Google drive Picker API, this will upload the file on to the screen and with the help of Google docs viewer API and then share using Send button present beside the message text box.
3. Using send button to share the file is must by the Admin.
4. Once shared then only the normal users can view the selected file or else they cant.
5. Any number of users can be connected to the URL, this will allow them to chat with each other, this step uses Google channel API.

Result - Can view google drive files on to the application and also parallely chat with other users who are logged in to the application.