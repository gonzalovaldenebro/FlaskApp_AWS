from flask import Flask
from flask import Flask 
from flask import render_template 
import boto3
from boto3.dynamodb.conditions import Key 
import pymysql 
import creds

app = Flask(__name__)

@app.route ('/')
def home_page():
    return render_template('home.html')
    
def display_expectancy_html(rows):
    html = ""
    html += """<table><tr><th>Name</th><th>Region</th><th>GovernmentForm</th><th>LifeExpectancy</th><th>Language</th></tr>"""
    for r in rows:
        html += "<tr><td>" + str(r[0]) + "</td><td>" + str(r[1]) + "</td><td>" + str(r[2]) + "</td><td>" + str(r[3]) + "</td><td>" + str(r[4]) + "</td></tr>"
    html += "</table></body>"
    html +="<a href='/'> Homepage </body>"
    return html
    
def get_conn():
    conn = pymysql.connect(
        host= creds.host,
        user= creds.user, 
        password = creds.password,
        db=creds.db,
        )
    return conn

def execute_query(query, args=()):
    cur = get_conn().cursor()
    cur.execute(query, args)
    rows = cur.fetchall()
    cur.close()
    return rows

def viewlife_expectancy(lifeExpectancy):
    rows = execute_query("""
    SELECT country.Name, country.Region ,country.GovernmentForm, country.LifeExpectancy, countrylanguage.Language as Language
    FROM countrylanguage 
    JOIN country ON countrylanguage.CountryCode = country.Code
    WHERE country.LifeExpectancy <= %s
    ORDER BY country.LifeExpectancy asc
    """, (str(lifeExpectancy))) 
    return display_expectancy_html(rows)

from flask import request 
@app.route("/databasetextbox", methods = ['GET']) 
def expectancy_form(): 
    return render_template('textbox.html', fieldname = "lifeExpectancy") 

@app.route("/databasetextbox", methods = ['POST']) 
def expectancy_form_post(): 
    text = request.form['text'] 
    return viewlife_expectancy(text)


############# NO SQL CRUD IMPLEMENTATION #################

TABLE_NAME = "World"
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(TABLE_NAME)


@app.route("/create_trip", methods = ['GET'])
def create_trip():
    return render_template("create.html")

@app.route("/create_trip", methods=['POST'])
def creating_trip():
    Name        = request.form.get('Name')
    Country     = request.form.get('Country')
    Cities      = request.form.get('Cities').split(',')
    TripRating  = request.form.get('TripRating')
    TripYear    = request.form.get('TripYear')

    table.put_item(
        Item={
            'Name': Name,
            'Country': Country,
            'Cities': Cities,
            'TripRating': TripRating,
            'TripYear': TripYear
        }
    )

    return """<a href ="/">Home</a>"""

# Implementing the Read function
def print_trip(trip_dict):
    Name = trip_dict['Name']
    Country =  trip_dict['Country']
    Cities = trip_dict['Cities']
    trip_rating = trip_dict['TripRating']
    trip_year = trip_dict['TripYear']    
    #html = ''
    #html += """<table><tr><th>Name</th><th>Country</th><th>Cities</th><th>trip_rating</th><th>trip_year</th></tr><br/>"""
    #html += "<tr><td>" + Name + "</td><td>" + Country + "</td><td>" + Cities + "</td><td>" + str(trip_rating) + "</td><td>" + str(trip_year) + "</td></tr><br/>"
    if Cities:
        Cities = ', '.join(Cities)
    else:
        Cities = ""
    css = "<style>table, th, td { border: 1px solid black; border-collapse: collapse; padding: 10px; } th { font-weight: bold; background-color: #ccc; }</style>"
    
    # Build HTML table
    html = css
    html += "<table>"
    html += "<tr><th>Name</th><th>Country</th><th>Cities</th><th>TripRating</th><th>TripYear</th></tr>"
    html += "<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>".format(Name, Country, Cities, trip_rating, trip_year)
    html += "</table>"
    
    return html

@app.route("/read_trip")
def read_trip():
    done = False
    start_key = None
    html = ''
    
    if not start_key:
        start_key = None
    
    while not done:
        response = table.scan()
        for trip in response.get('Items', []):
            html += print_trip(trip)
        start_key = response.get('LastEvaluateKey', None)
        done = start_key is None
        
    html += """ <a href="/"> Home</a> """
    return html

# Implementing the Update function
@app.route("/update_trip", methods = ['GET'])
def update_trip():
    return render_template('update_trip.html')

@app.route("/update_trip", methods = ['POST'])
def updating_trip():
    name = request.form.get('name')
    trip_Rating = request.form.get('trip_rating')
    
    table.update_item(
        Key = {
            'Name': name
        },
        UpdateExpression = "SET TripRating = :r",
            ExpressionAttributeValues = {
                ':r':trip_Rating,
            }
    )

    return """<a href ="/">Home</a>"""
    #render_template('update_trip.html')

# Implementing the Delete function
@app.route("/delete_trip", methods = ['GET'])
def delete_trip():
    return render_template('delete_trip.html')

@app.route("/delete_trip", methods = ['POST'])
def deleting_trip():
    name = request.form.get('name')
    table.delete_item(
        Key={
            'Name': name,
        }
)
    return """<a href ="/">Home</a>"""
    #render_template('delete_trip.html')

# Implementing the user input functon
@app.route("/input_trip", methods = ['GET'])
def input_trip_get():
    return render_template("crud.html")
    
@app.route("/input_trip", methods = ['POST'])
def input_trip_post():
    input_char = request.form["choice"]
    if input_char.upper() == "C":
        return """ <a href = "/create_trip"> Lets create a trip!"""
    elif input_char.upper() == "R":
        return """ <a href = "/read_trip"> Lets show all trips!"""
    elif input_char.upper() == "U":
        return """ <a href = "/update_trip"> Lets update a trip rating!"""
    elif input_char.upper() == "D":
        return """ <a href = "/delete_trip"> Lets delete a trip """
    
    return """<a href ="/">Home</a>"""
    
# These two lines of code should always be the last in the file 
if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 8080, debug = True)