import mariadb
from flask import Flask

connection = mariadb.connect(
        user = 'root',
        password = 'utq0975e',
        database = 'abldb',
        host = '127.0.0.1'
        )

cursor = connection.cursor()
query = '''SELECT name FROM `patients`'''
cursor.execute( query )
for name in cursor:
    print( name )

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '<html><body><p>ahobokekasu</p></body></html>'

if __name__ == '__main__':
    app.run()
