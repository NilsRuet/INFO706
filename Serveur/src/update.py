from init import *
import datetime
import bottle

@app.route('/update_student', method='PUT')
def update_student(db):
    id = bottle.request.params.get('id')
    username = bottle.request.params.get('name')
    query = "UPDATE {0} SET {2} = '{4}' WHERE {0}.{1} = {3};".format(user_table, user_id, user_name, id, username)
    db.execute(query)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = {4}'
    .format(user_table, user_id, student_table, student_id, id))
    bottle.response.status = 200
    return db.fetchone()

@app.route('/update_teacher', method='PUT')
def update_teacher(db):
    id = bottle.request.params.get('id')
    username = bottle.request.params.get('name')
    query = "UPDATE {0} SET {2} = '{4}' WHERE {0}.{1} = {3};".format(user_table, user_id, user_name, id, username)
    db.execute(query)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = {4}'
    .format(user_table, user_id, teacher_table, teacher_id, id))
    bottle.response.status = 200
    return db.fetchone()

@app.route('/update_skill_block', method='PUT')
def update_block(db):
    id = bottle.request.params.get('id')
    title = bottle.request.params.get('title')
    query = "UPDATE {0} SET {2} = '{4}' WHERE {0}.{1} = {3};".format(blocks_table, blocks_id, blocks_title, id, title)
    db.execute(query)
    db.execute('SELECT * from {0} WHERE {0}.{1} = {2}'
    .format(blocks_table, blocks_id, id))
    bottle.response.status = 200
    return db.fetchone()

@app.route('/update_global_skill', method='PUT')
def update_global_skill(db):
    id = bottle.request.params.get('id')
    name = bottle.request.params.get('name')
    level = bottle.request.params.get('level')
    block = bottle.request.params.get('block_id')
    query = "UPDATE {0} SET {1} = '{4}', {2} = '{5}', {3} = '{6}' WHERE {0}.{7} = {8};".format(
                                                                                        skills_table,
                                                                                        skill_name,
                                                                                        skill_level,
                                                                                        skill_block,
                                                                                        name,
                                                                                        level,
                                                                                        block,
                                                                                        skill_id,
                                                                                        id)
    db.execute(query)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = {4}'
    .format(skills_table, skill_id, global_skills_table, global_skills_id, id))
    bottle.response.status = 200
    return db.fetchone()

@app.route('/update_personal_skill', method='PUT')
def update_personal_skill(db):
    id = bottle.request.params.get('id')
    name = bottle.request.params.get('name')
    level = bottle.request.params.get('level')
    block = bottle.request.params.get('block_id')
    query = "UPDATE {0} SET {1} = '{4}', {2} = '{5}', {3} = '{6}' WHERE {0}.{7} = {8};".format(
                                                                                        skills_table,
                                                                                        skill_name,
                                                                                        skill_level,
                                                                                        skill_block,
                                                                                        name,
                                                                                        level,
                                                                                        block,
                                                                                        skill_id,
                                                                                        id)
    db.execute(query)
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3} AND {0}.{1} = {4}'
    .format(skills_table, skill_id, personal_skills_table, personal_skill_id, id))
    bottle.response.status = 200
    return db.fetchone()