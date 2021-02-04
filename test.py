import mariadb
from flask import *
from flask_cors import CORS

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

patients_list = [{
        "patientSerialNumber": 1,
        "baseline": False,
        "firstAblation": True,
        "followingAblation": False
        }]

app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
    return '<html><body><p>ahobokekasu</p></body></html>'

@app.route('/api/patients', methods=['GET', 'POST'])
def list_patients():
    return jsonify(patients_list)

if __name__ == '__main__':
    app.run()
