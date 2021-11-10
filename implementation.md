# CIVS Implementation Notes

## Code Structure

The CIVS source code is written in a mixture of Perl, HTML, JavaScript. Most of the code is written
in Perl using the CGI package and is found in the cgi-bin directory.

## Persistent storage

All persistent data is stored under the CIVS home directory.

Data about elections is stored in separate directories under the elections/ subdirectory.  Within each such directory, data is put into Berkeley DB databases.
Data about the election is in one database, and voting data is stored in a
separate database.

Data about the service as a whole is stored in files at the level of the CIVS home directory or one level down in the elections/ directory.

It is important to set the permissions and ownership correctly on files under the CIVS home directory, so that the web server can access and create the files it needs to, and so that other users cannot.

## Strings and character encodings

Strings are mostly represented internally as full Unicode strings, in which
each character in the string represents exactly one single Unicode character. However,
data sent to web pages, email, and the back-end databases must be encoded into UTF-8.
Cached poll results are also stored in files using UTF-8.
