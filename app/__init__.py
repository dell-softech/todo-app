import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)

    app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
    "DATABASE_URL",
    "sqlite:///todo.db"
)

    db.init_app(app)

    from .models import Task
    from .routes import main

    app.register_blueprint(main)

    with app.app_context():
        db.create_all()

    return app