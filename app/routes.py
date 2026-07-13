from flask import Blueprint
from flask import render_template
from flask import request
from flask import redirect

from . import db
from .models import Task

main = Blueprint("main", __name__)


@main.route("/", methods=["GET", "POST"])
def home():

    if request.method == "POST":

        title = request.form["task"]

        task = Task(title=title)

        db.session.add(task)
        db.session.commit()

        return redirect("/")

    tasks = Task.query.all()

    return render_template(
        "index.html",
        tasks=tasks
    )


@main.route("/delete/<int:id>")
def delete(id):

    task = Task.query.get_or_404(id)

    db.session.delete(task)
    db.session.commit()

    return redirect("/")