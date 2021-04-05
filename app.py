import mariadb
import re
from datetime import date, datetime
from flask import *
from flask_cors import CORS

class Database:
    def __init__(self, **dns):
        self.dns = dns
        self.dbh = None

    def _open(self):
        self.dbh = mariadb.connect(**self.dns)

    def _close(self):
        self.dbh.close()

    def _commit(self):
        self.dbh.commit()

    def query(self, stmt, *args, **kwargs):
        #print(id(self))
        self._open()
        print( 'STMT is ' + stmt )
        if kwargs.get('prepared', False):
            cursor = self.dbh.cursor(prepared=True, dictionary=True, buffered=True)
            cursor.execute(stmt, args)
        else:
            cursor = self.dbh.cursor(dictionary=True, buffered=True)
            cursor.execute(stmt)
        if 'INSERT' in stmt or 'UPDATE' in stmt:
            self._commit()
            data = None
        else:
            data = cursor.fetchall()
        if kwargs.get('last_id', False):
            cursor.execute( 'SELECT last_insert_id();' )
            inserted_id = cursor.fetchone()['last_insert_id()']
            cursor.close()
            self._close()
            print( 'Inserted ID is ' + str( inserted_id  ))
            return inserted_id
        else:
            cursor.close()
            self._close()
            print( 'Data is ' + str( data ))
            return data

dns = {
        'user': 'root',
        'host': '127.0.0.1',
        'password': 'utq0975e',
        'database': 'abldb'
        }
#db = Database(**dns)

def get_cursor():
    connection = mariadb.connect(
            user = 'root',
            password = 'utq0975e',
            database = 'abldb',
            host = '127.0.0.1'
            )
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
    #print( data )
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
    db = Database(**dns)
    query = '''
        INSERT INTO `ucg` () VALUES();
    '''
    new_id = db.query( query, last_id=True )
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.execute( 'SELECT last_insert_id();' )
    #new_id = cursor.fetchone()
    #cursor.close()
    return new_id

def create_new_medicine():
    db = Database(**dns)
    query = '''
        INSERT INTO `internal_medicine` () VALUES ();
    '''
    new_id = db.query( query, last_id=True )
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.execute( 'SELECT last_insert_id();' )
    #new_id = cursor.fetchone()
    #cursor.close()
    return new_id

app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
    return '<html><body><p>It works.</p></body></html>'

@app.route('/api/patients', methods=['GET'])
def list_patients():
    db = Database(**dns)
    #cursor = get_cursor()
    query = '''
        SELECT * FROM patient_list
            ORDER BY `patient_serial_number`;
    '''
    #cursor.execute( query )
    #patients_list = cursor.fetchall()
    patients_list = db.query( query )
    for row in patients_list:
        pt_number = row['patient_serial_number']
        query_follow_abl = f'''
            SELECT `following_ablation_id` FROM `following_ablation`
                WHERE `patient_serial_number` = { pt_number }
                ORDER BY `date`;
        '''
        #cursor.execute( query_follow_abl )
        #res_follow_abl = cursor.fetchall()
        res_follow_abl = db.query( query_follow_abl )
        row['following_ablations'] = list( map( lambda x: x['following_ablation_id'], res_follow_abl ))
    #cursor.close()
    patients_list = list( map( format_data_to_cast, patients_list ) )
    return jsonify( patients_list )

@app.route('/api/patients/<int:patient_serial_number>', methods=['GET'])
def give_a_patient(patient_serial_number):
    db = Database(**dns)
    #cursor = get_cursor()
    query = f'''
        SELECT * FROM `patient_list`
            WHERE `patient_serial_number` = { patient_serial_number };
    '''
    #cursor.execute( query )
    #patient = cursor.fetchone()
    patient = db.query( query )[0]
    query_follow_abl = f'''
        SELECT `following_ablation_id` FROM `following_ablation`
            WHERE `patient_serial_number` = { patient_serial_number }
            ORDER BY `date`;
    '''
    #cursor.execute( query_follow_abl )
    #res_follow_abl = cursor.fetchall()
    res_follow_abl = db.query( query_follow_abl )
    patient['following_ablations'] = list( map( lambda x: x['following_ablation_id'], res_follow_abl ))
    #cursor.close
    return jsonify( format_data_to_cast( patient ) )

@app.route('/api/baseline/new', methods=['GET'])
def get_new_pt_number():
    db = Database(**dns)
    header = request.headers.get("Authorization")
    _,token = header.split()
    user_id = validiate_token(token)
    query = f'''
        INSERT INTO `patients` 
            (`registered_by`)
        VALUES ({user_id});
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.execute('SELECT last_insert_id();')
    #new_id = cursor.fetchone()
    patient_id = db.query( query, last_id=True )
    #patient_id = new_id['last_insert_id()']
    #cursor.close()
    #cursor = get_cursor()
    ucg_id = create_new_ucg()
    query = f'''
        UPDATE `patients`
            SET `ucg_id` = { ucg_id }
        WHERE `patient_serial_number` = { patient_id };
    '''
    #cursor.execute( query )
    #cursor.close()
    db.query( query )
    return str( patient_id )

@app.route('/api/baseline/<int:patient_serial_number>', methods=['GET'])
def give_baseline_data(patient_serial_number):
    db = Database(**dns)
    #cursor = get_cursor()
    query = f'''
        SELECT * FROM `patients`
            WHERE `patient_serial_number` = {patient_serial_number};
    '''
    #cursor.execute( query )
    #baseline = cursor.fetchone()
    baseline = db.query( query )[0]
    #cursor.close()
    #print( format_data_to_cast( baseline ) )
    return jsonify( format_data_to_cast( baseline ))

@app.route('/api/baseline/<int:patient_serial_number>', methods=['POST'])
def update_baseline_data(patient_serial_number):
    db = Database(**dns)
    baseline_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `patients` 
            SET { baseline_data }
        WHERE `patient_serial_number` = {patient_serial_number};
    '''
    #print( query )
    db.query( query )
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close()
    return "ok"

@app.route('/api/ucg/new', methods=['GET'])
def get_new_ucg_number():
    db = Database(**dns)
    query = '''
        INSERT INTO `ucg`
        (`lvdd`)
        VALUES (NULL);
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #new_id = cursor.execute( 'SELECT last_insert_id();' )
    #new_id = cursor.fetchone()
    #cursor.close()
    new_id = db.query( query, last_id=True )
    #print( new_id )
    return jsonify( new_id )

@app.route('/api/ucg/<int:ucg_id>', methods=['GET'])
def give_ucg_data(ucg_id):
    db = Database(**dns)
    query = f'''
        SELECT * FROM `ucg`
            WHERE `ucg_id` = { ucg_id };
    '''
    #print( query )
    #cursor = get_cursor()
    #cursor.execute( query )
    #ucg = cursor.fetchone()
    #cursor.close()
    ucg = db.query( query )[0]
    return jsonify( format_data_to_cast( ucg ) )

@app.route('/api/ucg/<int:ucg_id>', methods=['POST'])
def update_ucg_data(ucg_id):
    db = Database(**dns)
    ucg_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `ucg`
            SET { ucg_data }
        WHERE `ucg_id` = { ucg_id };
    '''
    #print( query );
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close()
    db.query( query )
    return "ok"

@app.route('/api/1st-abl/<int:patient_serial_number>', methods=['GET'])
def give_first_abl_data(patient_serial_number):
    db = Database(**dns)
    q_data = f'''
        SELECT * FROM `first_ablation`
            WHERE `patient_serial_number` = { patient_serial_number };
    '''
    q_new_data = f'''
        INSERT INTO `first_ablation`
            (`patient_serial_number`)
        VALUES ( { patient_serial_number } );
    '''
    #cursor = get_cursor()
    #cursor.execute( q_data )
    #result = cursor.fetchall()
    result = db.query( q_data )
    #print( result )
    if len( result ) == 0:
        print( q_new_data )
        #cursor.execute( q_new_data )
        #connection.commit()
        #cursor.execute( q_data )
        #abl_data = cursor.fetchone()
        db.query( q_new_data )
        abl_data = db.query(q_data)[0]
    else:
        abl_data = result[0]
    #print( abl_data )
    #cursor.close()
    return jsonify( format_data_to_cast( abl_data ) )

@app.route('/api/1st-abl/<int:patient_serial_number>', methods=['POST'])
def update_first_abl_data(patient_serial_number):
    db = Database(**dns)
    abl_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `first_ablation`
            SET { abl_data }
        WHERE `patient_serial_number` = { patient_serial_number };
    '''
    #print( query )
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close()
    db.query( query )
    return 'First ablation update: SUCCESS'

@app.route('/api/1st-abl/<int:first_abl_id>/medication_id', methods=['GET'])
def give_med_id_for_first_abl(first_abl_id):
    db = Database(**dns)
    query = f'''
        SELECT `internal_medicine_id` FROM `first_ablation`
            WHERE `first_ablation_id` = { first_abl_id };
    '''
    q_new_medicine = "INSERT INTO `internal_medicine` () VALUES ();"
    #cursor = get_cursor()
    #cursor.execute( query )
    #result = cursor.fetchone()
    result = db.query( query )[0]
    medicine_id = result[ 'internal_medicine_id' ]
    if medicine_id is None:
        #cursor.execute( q_new_medicine )
        #connection.commit()
        #cursor.execute( 'SELECT last_insert_id();' )
        #result = cursor.fetchone()
        #print( result )
        #medicine_id = result['last_insert_id()']
        medicine_id = db.query( q_new_medicine, last_id=True )
        q_register_medicine = f'''
            UPDATE `first_ablation`
                SET `internal_medicine_id` = { medicine_id }
                WHERE `first_ablation_id` = { first_abl_id };
        '''
        #cursor.execute( q_register_medicine )
        #connection.commit()
        db.query( q_register_medicine )
    #cursor.close()
    return jsonify(medicine_id)

@app.route('/api/medication/<int:medication_id>', methods=['GET'])
def give_medication_data(medication_id):
    db = Database(**dns)
    query = f'''
        SELECT * FROM `internal_medicine`
            WHERE `internal_medicine_id` = { medication_id }
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #medication_data = cursor.fetchone()
    #cursor.close()
    medication_data = db.query( query )[0]
    return jsonify( format_data_to_cast( medication_data ) )

@app.route('/api/medication/<int:medication_id>', methods=['POST'])
def update_medication_data(medication_id):
    db = Database(**dns)
    medication_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `internal_medicine`
            SET { medication_data }
        WHERE `internal_medicine_id` = { medication_id };
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close
    db.query( query )
    return "ok"

@app.route('/api/following_ablation/new/<int:patient_serial_number>', methods=['GET'])
def get_new_follow_ablation_number(patient_serial_number):
    db = Database(**dns)
    query = f'''
        INSERT INTO `following_ablation`
            ( patient_serial_number ) VALUES ( { patient_serial_number } );
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #new_id = cursor.execute( 'SELECT last_insert_id();' )
    #new_id = cursor.fetchone()
    #follow_ablation_id = new_id['last_insert_id()']
    follow_ablation_id = db.query( query, last_id=True )
    #cursor.close()
    ucg_id = create_new_ucg()
    medicine_id = create_new_medicine()
    query = f'''
        UPDATE `following_ablation`
            SET `ucg_id` = { ucg_id }, `internal_medicine_id` = { medicine_id }
        WHERE `following_ablation_id` =  { follow_ablation_id };
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close()
    db.query( query )
    return jsonify( follow_ablation_id )

@app.route('/api/following_ablation/<int:following_ablation_id>', methods=['GET'])
def give_following_ablation_data(following_ablation_id):
    db = Database(**dns)
    query = f'''
        SELECT * FROM `following_ablation`
            WHERE `following_ablation_id` = { following_ablation_id };
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #follow_ablation = cursor.fetchone()
    #print( follow_ablation )
    #cursor.close()
    follow_ablation = db.query( query )[0]
    return jsonify( format_data_to_cast( follow_ablation ) )

@app.route('/api/following_ablation/<int:following_ablation_id>', methods=['POST'])
def update_following_ablation_data(following_ablation_id):
    db = Database(**dns)
    following_ablation_data = format_data_to_insert( request.json )
    query = f'''
        UPDATE `following_ablation`
            SET { following_ablation_data }
        WHERE `following_ablation_id` = { following_ablation_id };
    '''
    #cursor = get_cursor()
    #cursor.execute( query )
    #connection.commit()
    #cursor.close()
    db.query( query )
    return "ok"

if __name__ == '__main__':
    app.run( threaded=True, debug=True )