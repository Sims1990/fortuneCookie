from flask import Flask, render_template, request, redirect, url_for

import mysql.connector

import boto3

import requests

#MySql connection
cnx = mysql.connector.connect(host='localhost',database='FortuneTest',
user='root',password='password')

cursor = cnx.cursor()

#SQS Client created
#sqs = boto3.resource('sqs')

app = Flask(__name__)
app.config["DEBUG"] = True

fortunes = []

@app.route("/")
def hello():
    return render_template('Home.html')

@app.route("/About")
def about():
    return render_template('About.html')

@app.route("/Fortune")
def fortune():
    query = "SELECT BODY from Entry ORDER BY RAND() LIMIT 0,1"
    cursor.execute(query)
    data = cursor.fetchone()

    return render_template('launch.html', data=data)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

@app.route("/Submit", methods=["GET", "POST"])
def submit():
    if request.method == "GET":
      return render_template('Submit.html', fortune=fortunes)

    fortunes.append(request.form["contents"])
    queue = sqs.get_queue_by_name(QueueName='FortuneSubmitted')
    response = queue.send_message(MessageBody=str(fortunes[0]))
    fortunes.clear()
    return redirect(url_for('submit'))
