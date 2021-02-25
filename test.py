import mariadb
import re
from datetime import date, datetime
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
    pattern = re.compile(r'([A-Z])')
    result = pattern.sub(r'_\1', string)
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

def format_value(value):
    if value is None:
        return "NULL"
    elif isinstance( value, int ):
        return str( value )
    elif isinstance( value, date ):
        return "\'" + value.strptime( "%Y-%m-%d" ) + "\'"
    elif value == True:
        return "\'b\'1"
    elif  value == False:
        return"\'b\'0"
    else:
        return f"\'{str( value )}\'"

def format_data_to_insert(data):
    data = format_dic(data, 'snake')
    data_pairs = map( lambda k: '`' + k + '`' + " = " + format_value( data[k] ), data )
    return ','.join( data_pairs )

def format_data_to_cast(data):
    data  = format_dic( data, 'camel' )
    print( data )
    data_to_cast = {}
    for k, v in data.items():
        if v == b'\x00':
            data_to_cast[k] = False
        elif v == b'\x01':
            data_to_cast[k] = True
        elif isinstance( v, date ):
            data_to_cast[k] = v.strftime( '%Y-%m-%d' )
        else:
            data_to_cast[k] = v
    return data_to_cast

def create_new_ucg():
    query = '''
        INSERT INTO `ucg` () VALUES();
    '''
    cursor = get_cursor()
    cursor.execute( query )
    connection.commit()
    cursor.execute( 'SELECT last_insert_id();' )
    new_id = cursor.fetchone()
    cursor.close()
    return new_id['last_insert_id()']

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
    patient_id = new_id['last_insert_id()']
    cursor.close()
    cursor = get_cursor()
    ucg_id = create_new_ucg()
    query = f'''
        UPDATE `patients`
            SET `ucg_id` = { ucg_id }
        WHERE `patient_serial_number` = { patient_id };
    '''
    cursor.execute( query )
    cursor.close()
    return str( patient_id )

@app.route('/api/baseline/<int:patient_serial_number>', methods=['GET'])
def give_baseline_data(patient_serial_number):
    cursor = get_cursor()
    query = f'''
        SELECT * FROM `patients`
            WHERE `patient_serial_number` = {patient_serial_number};
    '''
    cursor.execute( query )
    baseline = cursor.fetchone()
    cursor.close()
    print( format_data_to_cast( baseline ) )
    return jsonify( format_data_to_cast( baseline ))

@app.route('/api/baseline/<int:patient_serial_number>', methods=['POST'])
def update_baseline_data(patient_serial_number):
    baseline_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `patients` 
            SET { baseline_data }
        WHERE `patient_serial_number` = {patient_serial_number};
    '''
    print( query )
    cursor = get_cursor()
    cursor.execute( query )
    connection.commit()
    cursor.close()
    return "ok"

@app.route('/api/ucg/new', methods=['GET'])
def get_new_ucg_number():
    query = '''
        INSERT INTO `ucg`
        (`lvdd`)
        VALUES (NULL);
    '''
    cursor = get_cursor()
    cursor.execute( query )
    connection.commit()
    new_id = cursor.execute( 'SELECT last_insert_id();' )
    new_id = cursor.fetchone()
    cursor.close()
    print( new_id )
    return jsonify( new_id['last_insert_id()'] )

@app.route('/api/ucg/<int:ucg_id>', methods=['GET'])
def give_ucg_data(ucg_id):
    query = f'''
        SELECT * FROM `ucg`
            WHERE `ucg_id` = { ucg_id };
    '''
    cursor = get_cursor()
    cursor.execute( query )
    ucg = cursor.fetchone()
    cursor.close()
    return jsonify( format_data_to_cast( ucg ) )

@app.route('/api/ucg/<int:ucg_id>', methods=['POST'])
def update_ucg_data(ucg_id):
    ucg_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `ucg`
            SET { ucg_data }
        WHERE `ucg_id` = { ucg_id };
    '''
    print( query );
    cursor = get_cursor()
    cursor.execute( query )
    connection.commit()
    cursor.close()
    return "ok"

@app.route('/api/1st-abl/<int:patient_serial_number>', methods=['GET'])
def give_first_abl_data(patient_serial_number):
    q_data = f'''
        SELECT * FROM `first_ablation`
            WHERE `patient_serial_number` = { patient_serial_number };
    '''
    q_new_data = f'''
        INSERT INTO `first_ablation`
            (`patient_serial_number`)
        VALUES ( { patient_serial_number } );
    '''
    cursor = get_cursor()
    cursor.execute( q_data )
    result = cursor.fetchall()
    cursor.close()
    return jsonify( len( result ))

if __name__ == '__main__':
    app.run()
