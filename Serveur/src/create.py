from init import *
from datetime import date, datetime
import bottle

@app.route('/add_student', method='POST')
def add_student(db):
    username = bottle.request.forms.get('name')
    query = "INSERT INTO {0} ({1}) VALUES ('{2}');".format(user_table, user_name, username)
    query2 = "INSERT INTO {0}({1}) VALUES (LAST_INSERT_ID())".format(student_table, student_id)
    db.execute(query)
    db.execute(query2)
    return {root_keyword:"success"}

@app.route('/add_teacher')
def add_teacher(db):

    return {root_keyword:res}

@app.route('/add_global_skill')
def add_global_skill(db):

    return {root_keyword:res}

@app.route('/add_personal_skill')
def add_personal_skill(db, user_id):

    return {root_keyword:res}

@app.route('/add_self_assessment')
def add_self_assessment(db, user_id):


    return {root_keyword:res}

@app.route('/add_teacher_assessment')
def add_teacher_assessment(db, user_id):


    return {root_keyword:res}