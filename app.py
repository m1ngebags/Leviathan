from flask import Flask, session, redirect, url_for, escape, request, render_template, flash, jsonify, json
from functools import wraps
from pymongo import MongoClient
import bson.json_util
import hashlib

app = Flask(__name__)

client = MongoClient()
db = client['leviathan']
acctdb = db['accounts']

def hashy(s):
    sha = hashlib.sha512()
    sha.update(s)
    return sha.hexdigest()

#TODO: sanitize input, sanity checks, whatever
def checkRegistration(username,password):
    errors = []
    user = acctdb.find({'username':username})
    user = [u for u in user]
    if len(user)>0: 
        errors += ["user with that name already exists"]
    if len(username) < 3:
        errors += ["username too short"]
    if username in ["admin","jamal"]:
        errors += ["cannot use that name"]
    return errors
    
def registerUser(username,password):
    newuser = {'username':username,
               'passhash':hashy(password)}
    acctdb.save(newuser)
    return True

#>implying security
#TODO: figure out login session security
def checkLogin(username,password):
    errors = []
    user = acctdb.find({'username':username})
    user = [u for u in user]
    if len(user)>1:
        errors += ['something broke horribly']
    elif len(user)<1:
        errors += ['user does not exist']
    else:
        user = user[0]
        phash = hashy(password)
        if user['passhash'] != phash:
            errors += ['incorrect password']
    return errors
            
@app.route("/")
@app.route("/index")
def index_html():
    return render_template("index.html")

@app.route("/login", methods=['GET','POST'])
def login_html():
    if request.method == 'POST':
        errors = checkLogin(request.form['username'],
                            request.form['password'])
        if len(errors)>0:
            return render_template("login.html",
                                   errors=errors)
        else:
            session['username'] = request.form['username']
            flash('login sucessful')
            return redirect('/index')
    else:
        return render_template("login.html")

@app.route("/register", methods=['GET','POST'])
def register_html():
    errors = []
    if 'username' in session:
        flash("already logged in")
        return redirect('/index')
    elif request.method == 'POST':
        errors = checkRegistration(request.form['username'],
                                   request.form['password'])
        if len(errors)>0:
            return render_template('register.html',
                                   errors=errors)
        else:
            registerUser(request.form['username'],
                         request.form['password'])
            flash('you have registered successfully')
            flash('you may now log in')
            return redirect(url_for('login_html',
                                    errors=errors))
    else:
        return render_template('register.html',
                               errors=errors)

@app.route("/logout")
def logout_html():
    session.clear()
    flash("you have logged out")
    return redirect("/index")

@app.route("/user/<username>")
def userprofile_html(username):
    return username + "'s profile"

@app.route("/settings")
@app.route("/lobby")
def placeholder_html():
    return "PLACEHOLDER"


app.secret_key = 'tbsdesu'
if __name__ == "__main__":
    app.debug = True
    app.run(host = "0.0.0.0", port = 1247)

checkLogin("ayy","lmoa")
