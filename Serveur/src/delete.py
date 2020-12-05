from init import *
import datetime
import bottle

@app.route('/delete_user/<id>', method='DELETE')
def delete_user(db, id):
    query = "DELETE FROM {0} WHERE {1}={2}".format(user_table, user_id, id)
    db.execute(query)
    bottle.response.status = 202

@app.route('/delete_skill_block/<id>', method='DELETE')
def delete_skill_block(db, id):
    query = "DELETE FROM {0} WHERE {1}={2}".format(blocks_table, blocks_id, id)
    db.execute(query)
    bottle.response.status = 202

@app.route('/delete_skill/<id>', method='DELETE')
def delete_skill(db, id):
    query = "DELETE FROM {0} WHERE {1}={2}".format(skills_table, skill_id, id)
    db.execute(query)
    bottle.response.status = 202

@app.route('/delete_assessment/<id>', method='DELETE')
def delete_assessment(db, id):
    query = "DELETE FROM {0} WHERE {1}={2}".format(assessments_table, assessment_id, id)
    db.execute(query)
    bottle.response.status = 202