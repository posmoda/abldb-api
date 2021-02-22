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

def get_cursor():
    return connection.cursor(dictionary=True)

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

def format_dic_keys(tuple_of_dic, direction):
    new_list = []
    for row in tuple_of_dic:
        new_row = format_dic( row, direction )
        new_list.append( new_row )
    return new_list

def format_dic(dic, direction):
    new_row = {}
    for k, v in dic.items():
        if direction == 'camel':
            new_key = snake_to_camel(k)
        elif direction == 'snake':
            new_key = camel_to_snake(k)
        else:
            raise ValueError("error dayo")
        new_row[new_key] = v
    return new_row

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
    cursor = get_cursor()
    query = '''SELECT `patient_serial_number` FROM patients'''
    cursor.execute( query )
    patients_list = format_dic_keys( cursor.fetchall(), "camel" )
    for row in patients_list:
        row['baseline'] = True
    cursor.close()
    return jsonify(patients_list)

@app.route('/api/baseline/new', methods=['GET'])
def get_new_pt_number():
    header = request.headers.get("Authorization")
    _,token = header.split()
    user_id = validiate_token(token)
    query = f'''
        INSERT INTO `patients` 
            (`registered_by`)
        VALUES ({user_id});
    '''
    cursor = get_cursor()
    cursor.execute( query )
    connection.commit()
    cursor.execute('SELECT last_insert_id();')
    new_id = cursor.fetchone()
    print( new_id[0] )
    cursor.close()
    return str(new_id[0])

@app.route('/api/baseline/<int:patient_serial_number>', methods=['GET'])
def give_baseline_data(patient_serial_number):
    cursor = get_cursor()
    query = f'''
        SELECT * FROM `patients`
            WHERE `patient_serial_number` = {patient_serial_number};
    '''
    cursor.execute( query )
    baseline = cursor.fetchone()
    baseline['sex'] = int.from_bytes( baseline['sex'], byteorder='big' )
    cursor.close()
    return jsonify( format_dic( baseline, 'camel' ))

@app.route('/api/baseline/<int:patient_serial_number>', methods=['POST'])
def update_baseline_data(patient_serial_number):
    print(request.json)
    return "ok"

if __name__ == '__main__':
    app.run()
