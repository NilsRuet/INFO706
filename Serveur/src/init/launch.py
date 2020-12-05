import bottle
import bottle_mysql

app = bottle.Bottle()
plugin = bottle_mysql.Plugin(dbuser='info708', dbpass='info708', dbname='info708')
app.install(plugin)