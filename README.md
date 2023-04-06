# FlaskApp_AWS

FlaskApp_AWS is a web application created using Flask, a Python web framework, and is hosted on AWS EC2 Instance. The app is designed to have access to both a SQL database and a NoSQL database. The SQL database contains the famous world database, and the NoSQL database contains input from users and their trips.

## Features
### The app provides the following features:

SQL Query: Users can input a number, and the query will return all the countries that have that % of life expectancy or lower. The updated query is displayed on an HTML page.
NoSQL CRUD Operations: Users can create, read, update, or delete a value in the NoSQL database. The app prompts users to perform CRUD operations on the NoSQL database.
Databases
The app has two databases:

SQL Database: The SQL database is hosted on an RDS instance that was created for this purpose. It contains the famous world database.
NoSQL Database: The NoSQL database is hosted on a DynamoDB instance that was created for this purpose. It contains user input on their trips.
Hosting
The app is hosted on GitHub and is publicly accessible at https://github.com/gonzalovaldenebro/FlaskApp_AWS.

## Templates
The templates folder contains HTML files for each page. These templates allow users to input data and query the databases.

## SQL Query
The 'SQL Query' folder contains some of the queries that were tested and the final one used in the app.

## Flask App
The `Flask app` is located in the `Flask App` folder, where you can find the WorldTripApp.py file that contains the code for the app.

## Dependencies
The following dependencies are required to run the app:

- Flask
- Flask-WTF
- boto3
- mysql-connector-python

## How to Run

### To run the app, you need to:

- Clone the repository to your local machine
- Install the dependencies using pip
- Set up the SQL and NoSQL databases as mentioned above
- Run the Flask app using the command flask run in the terminal
