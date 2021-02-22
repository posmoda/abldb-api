import mariadb
import re
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

def up_matched(m):
    s = m.group(1)
    return s.upper()

def snake_to_camel(string):
    pattern = re.compile(r'_([a-z])')
    result = pattern.sub(up_matched, string)
    return result

def camel_to_snake(string):
    pattern = re.compile(r'[A-Z]')
    result = pattern.sub(r'_\0', string)
    return result.lower()

def validiate_token(token):
    if token == 'hanamogera':
        return 0
    else:
        return None

app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
    return '<html><body><p>It works.</p></body></html>'

@app.route('/api/patients', methods=['GET'])
def list_patients():
    return jsonify(patients_list)

@app.route('/api/baseline/new', methods=['GET'])
def get_new_pt_number():
    header = request.headers.get("Authorization")
    _,token = header.split()
    print( token )
    user_id = validiate_token(token)
    query = f'''
        INSERT INTO `patients` 
            (`registered_by`)
        VALUES ({user_id});
    '''
    print( query )
    cursor.execute( query )
    connection.commit()
    cursor.execute('SELECT last_insert_id();')
    new_id = cursor.fetchone()
    print( new_id[0] )
    return str(new_id)

@app.route('/api/baseline/<int:patient_serial_number>', methods=['GET'])
def give_baseline_data(patient_serial_number):
    data = {
            "patientSerialNumber": patient_serial_number,
            "sex": 0
            }
    return jsonify(data)

@app.route('/api/baseline/<int:patient_serial_number>', methods=['POST'])
def update_baseline_data(patient_serial_number):
    print(request.json)
    return "ok"

if __name__ == '__main__':
    app.run()
