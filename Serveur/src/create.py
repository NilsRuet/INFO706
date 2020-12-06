from init import *
import datetime
import bottle
import requests

@app.route('/authenticate', method='POST')
def authenticate(db):
    token = bottle.request.forms.get('token')
    isStudent = bottle.request.forms.get('isStudent')
    r = requests.get("https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token="+token)
    if r.status_code==200:
        info = r.json()
        name = info["name"]
        id = str(info["id"])
        pic = info["picture"]
        db.execute('SELECT * from {0} WHERE {0}.{1}={2}'
        .format(user_table, user_google_id, id))
        if(db.rowcount>0):
            res = db.fetchone()
            db.execute('SELECT * from {0} WHERE {0}.{1}={2}'
            .format(student_table, student_id, id))
            if(db.rowcount>0):
                res["isStudent"] = True
            else:
                res["isStudent"] = False
            bottle.response.status = 200
            return res
        else:
            if isStudent is None:
                bottle.response.status=442
                return ""
            elif isStudent:
                res = create_student_from_data(db, name, id, pic)
                res["isStudent"] = True 
                bottle.response.status = 201
                return res
            else:
                res = create_teacher_from_data(db, name, id, pic)
                res["isStudent"] = False
                bottle.response.status = 201
                return res
    else:
        bottle.response.status=442
        return ""


@app.route('/add_student', method='POST')
def add_student(db):
    username = bottle.request.forms.get('name')
    google_id = bottle.request.forms.get('id')
    pic = bottle.request.forms.get('picture')
    bottle.response.status = 201
    return create_student_from_data(db, username, google_id, pic)

def create_student_from_data(db, username, google_id, pic):
    print("GID : "+google_id)
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format(
        user_table,
        user_name,
        user_google_id,
        user_picture,
        username,
        google_id,
        pic)
    query2 = "INSERT INTO {0}({1}) VALUES (LAST_INSERT_ID())".format(student_table, student_id)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(user_table, user_id, student_table, student_id))

    res = db.fetchone()
    return res

@app.route('/add_teacher', method='POST')
def add_teacher(db):
    username = bottle.request.forms.get('name')
    google_id = bottle.request.forms.get('id')
    pic = bottle.request.forms.get('picture')
    bottle.response.status = 201
    return create_teacher_from_data(db, username, google_id, pic)

def create_teacher_from_data(db, username, google_id, pic):
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format(
        user_table,
        user_name,
        user_google_id,
        user_picture,
        username,
        google_id,
        pic)
    query2 = "INSERT INTO {0}({1}) VALUES (LAST_INSERT_ID())".format(teacher_table, teacher_id)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(user_table, user_id, teacher_table, teacher_id))
    res = db.fetchone()
    return res

@app.route('/add_skill_block', method='POST')
def add_block(db):
    title = bottle.request.forms.get('title')
    query = "INSERT INTO {0} ({1}) VALUES ('{2}');".format(blocks_table, blocks_title, title)
    db.execute(query)
    db.execute('SELECT * from {0} WHERE {0}.{1} = LAST_INSERT_ID()'
    .format(blocks_table, blocks_id))
    bottle.response.status = 201
    return db.fetchone()

@app.route('/add_global_skill', method='POST')
def add_global_skill(db):
    name = bottle.request.forms.get('name')
    level = bottle.request.forms.get('level')
    block = bottle.request.forms.get('block_id')
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format( skills_table,
                                                                                skill_name,
                                                                                skill_level,
                                                                                skill_block,
                                                                                name,
                                                                                level,
                                                                                block)
    query2 = "INSERT INTO {0}({1}) VALUES (LAST_INSERT_ID())".format(global_skills_table, global_skills_id)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(skills_table, skill_id, global_skills_table, global_skills_id))
    bottle.response.status = 201
    return db.fetchone()

@app.route('/add_personal_skill', method='POST')
def add_personal_skill(db):
    name = bottle.request.forms.get('name')
    level = bottle.request.forms.get('level')
    block = bottle.request.forms.get('block_id')
    student = bottle.request.forms.get('student_id')
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format( skills_table,
                                                                                skill_name,
                                                                                skill_level,
                                                                                skill_block,
                                                                                name,
                                                                                level,
                                                                                block)
    query2 = "INSERT INTO {0}({1}, {2}) VALUES (LAST_INSERT_ID(),'{3}')".format(personal_skills_table,
                                                                                personal_skill_id,
                                                                                personal_skill_student,
                                                                                student)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(skills_table, skill_id, personal_skills_table, personal_skill_id))
    bottle.response.status = 201
    return db.fetchone()

@app.route('/add_self_assessment', method='POST')
def add_self_assessment(db):
    student = bottle.request.forms.get('student_id')
    skill = bottle.request.forms.get('skill_id')
    date = bottle.request.forms.get('validation_date')
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format( assessments_table,
                                                                                assessment_student,
                                                                                assessment_skill,
                                                                                assessment_date,
                                                                                student,
                                                                                skill,
                                                                                date)
    query2 = "INSERT INTO {0}({1}) VALUES (LAST_INSERT_ID())".format( self_assessments_table, self_assessment_id)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(assessments_table, assessment_id, self_assessments_table, self_assessment_id))
    bottle.response.status = 201
    res = db.fetchone()
    for key in res:
        if(isinstance(res[key], (datetime.datetime, datetime.date))):
            res[key] = str(res[key])
    return res

@app.route('/add_teacher_assessment', method='POST')
def add_teacher_assessment(db):
    student = bottle.request.forms.get('student_id')
    skill = bottle.request.forms.get('skill_id')
    date = bottle.request.forms.get('validation_date')
    assessor = bottle.request.forms.get('assessor_id')
    query = "INSERT INTO {0} ({1},{2},{3}) VALUES ('{4}','{5}','{6}');".format( assessments_table,
                                                                                assessment_student,
                                                                                assessment_skill,
                                                                                assessment_date,
                                                                                student,
                                                                                skill,
                                                                                date)
    query2 = "INSERT INTO {0}({1}, {2}) VALUES (LAST_INSERT_ID(), '{3}')".format(teacher_assessments_table,
                                                                                teacher_assessment_id,
                                                                                teacher_assessment_assessor,
                                                                                assessor)
    db.execute(query)
    db.execute(query2)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = LAST_INSERT_ID()'
    .format(assessments_table, assessment_id, teacher_assessments_table, teacher_assessment_id))
    bottle.response.status = 201
    res = db.fetchone()
    for key in res:
        if(isinstance(res[key], (datetime.datetime, datetime.date))):
            res[key] = str(res[key])
    return res