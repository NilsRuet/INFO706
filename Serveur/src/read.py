from init import *
from datetime import date, datetime

@app.route('/students')
def get_students(db):
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3}'
    .format(user_table, user_id, student_table, student_id))
    res = db.fetchall()
    return {root_keyword:res}

@app.route('/teachers')
def get_teachers(db):
    db.execute('SELECT * from {0} INNER JOIN {2} ON {0}.{1}={2}.{3}'
    .format(user_table, user_id, teacher_table, teacher_id))
    res = db.fetchall()
    return {root_keyword:res}

@app.route('/skill_blocks')
def get_blocks(db):
    db.execute('SELECT * from {}'.format(blocks_table))
    res = db.fetchall()
    return {root_keyword:res}

@app.route('/global_skills')
def get_global_skills(db):
    db.execute('SELECT {0}.* from {0} INNER JOIN {2} ON {0}.{1}={2}.{3}'
    .format(skills_table, skill_id, global_skills_table, global_skills_id))
    res = db.fetchall()
    return {root_keyword:res}

@app.route('/skills_of/<user_id>')
def get_skills_of(db, user_id):
    db.execute(
      """(SELECT {0}.* FROM {0}
      INNER JOIN {2} ON {0}.{1} = {2}.{3} AND {2}.{4} = {5})
      """.format(skills_table,
      skill_id,
      personal_skills_table,
      personal_skill_id,
      personal_skill_student,
      user_id)
      )
    res = db.fetchall()
    return {root_keyword:res}

@app.route('/self_assessments_of/<user_id>')
def get_self_assessments_of(db, user_id):
    db.execute(
      """(SELECT * FROM {0}
      INNER JOIN {3} ON {0}.{1} = {3}.{4} AND {0}.{2} = {5})
      """.format(assessments_table,
      assessment_id,
      assessment_student,
      self_assessments_table,
      self_assessment_id,
      user_id)
      )
    res = db.fetchall()

    for i in range(len(res)):
      for key in res[i]:
        if(isinstance(res[i][key], (datetime, date))):
          res[i][key] = str(res[i][key])

    return {root_keyword:res}

@app.route('/teacher_assessments_of/<user_id>')
def get_teacher_assessments_of(db, user_id):
    db.execute(
      """(SELECT * FROM {0}
      INNER JOIN {3} ON {0}.{1} = {3}.{4} AND {0}.{2} = {5})
      """.format(assessments_table,
      assessment_id,
      assessment_student,
      teacher_assessments_table,
      teacher_assessment_id,
      user_id)
      )
    res = db.fetchall()

    for i in range(len(res)):
      for key in res[i]:
        if(isinstance(res[i][key], (datetime, date))):
          res[i][key] = str(res[i][key])

    return {root_keyword:res}