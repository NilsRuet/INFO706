import init
from init import app
from read import *
from create import *
from delete import *
from update import *

f = open("host.config", "r")
ip = f.readline()
p = int(f.readline())
app.run(host=ip, port=p)
