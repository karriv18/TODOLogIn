from flask import session, Flask, render_template, session, request, redirect, Markup
import mysql.connector
import re
from werkzeug.security import generate_password_hash
from flask_login import login_required, current_user
# database connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    db="todo_app"
)
# to access db without numerical data 
curs = conn.cursor(dictionary=True)

# to make this app a flask app
app = Flask(__name__)
app.secret_key = "hatodg"
# default page
@app.route('/', methods=["POST", "GET"])
def index():
    return render_template("signin.html")


# email pattern
email_patt = r'^[\w\.-]+@[\w\.-]+\.\w+$'
@app.route("/signup", methods=["POST", "GET"])
def signup():
    if request.method == "POST":
        fname = request.form.get("fname") 
        mname = request.form.get("mname")
        lname = request.form.get("lname")
        email = request.form.get("email")
        pword = request.form.get("pass")

        # Form validation
        if not re.match(email_patt, email):
            return f'<h1>Invalid Email Format!</h1>'
        if not fname:
            return f"<h1>First Name is Required</h1>"
        if not lname:
            return f"<h1>Last Name is Required</h1>"
        if not email:
            return f"<h1>Email is Required</h1>"
        if not pword:
            return f"<h1>Password Required</h1>"

        # Registering to the database
        sql_sel = "INSERT INTO tbl_todo(first_name, middle_name, last_name, email, pword) VALUES(%s, %s, %s, %s, %s)"
        param = (fname, mname, lname, email, pword)
        curs.execute(sql_sel, param)
        conn.commit()

        return redirect('/')
    else:
        return render_template("signup.html")

# log in with database validation
@app.route("/login", methods=["POST", "GET"])
def login():

    if request.method == "POST":
        email = request.form.get("email")
        pword = request.form.get("pword")

        # email validation 
        if not re.match(email_patt, email):
            return f'<h1>Invalid Email Format!</h1>'
        
        sql_val = "SELECT * FROM tbl_todo WHERE email = %s AND pword = %s"
        param = (email, pword)
        curs.execute(sql_val, param)

        # fetching session 
        login_val = curs.fetchone()
        
        if not login_val:
            return f'<h1>User does not exist!</h1>'
        uid = login_val["id"]
        session['uid'] = uid
        
        return redirect("/add") 
    else:
        return redirect("/login")    

# adding task 
@app.route("/add", methods=["POST", "GET"])
def add():
    if request.method == "POST":
        # getting session to the database 
        user_id = int(session.get('uid'))
        todo = request.form.get("todo")

        # checking if todo is empty
        if not todo:
            return redirect("/fail")
        sql_ins = "INSERT INTO tbl_todo_info(id, task) VALUES(%s, %s)"

        # inserting to do 
        curs.execute(sql_ins, (user_id, todo))
        conn.commit()
        return redirect("/prof")

    else:
        return redirect("/prof")

# getting the inserted task 
def task():
    user_id = session.get('uid')
    sql_sel = curs.execute("SELECT * FROM tbl_todo_info WHERE id = %s", (user_id,))
    result = curs.fetchall()
    return result

#  routing to the profile
@app.route("/prof")
def profile():
    result = task()
    return render_template("profile.html", result=result)

# prompting failure.html 
@app.route("/fail")
def failure():
    return render_template("failure.html"), 400

# clearing front end session 
@app.route("/logout", methods=["POST"])
def logout():
    session.pop('user_id', None) # removing the key 
    session.clear()
    return render_template("signin.html")

# deleting task 
@app.route("/delete")
def delete():
    id = request.args.get("id")
    sql_del = "DELETE FROM tbl_todo_info WHERE todo_id = %s"
    
    curs.execute(sql_del, (id,))
    conn.commit()
    return redirect("/prof")