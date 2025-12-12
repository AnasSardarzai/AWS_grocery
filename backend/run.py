from app import create_app
import logging
from logging.handlers import RotatingFileHandler
import boto3
import watchtower
from flask import request
import traceback

# -----------------------
# Flask-App erstellen
# -----------------------
app = create_app()

# -----------------------
# Logging konfigurieren
# -----------------------

# Logger-Level setzen
app.logger.setLevel(logging.INFO)

# -----------------------
# File-Logging (lokal, Rotation aktiviert)
# -----------------------
file_handler = RotatingFileHandler("app.log", maxBytes=1_000_000, backupCount=3)
file_handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
app.logger.addHandler(file_handler)

# -----------------------
# CloudWatch-Logging mit festgelegter Region
# -----------------------
cloudwatch_handler = watchtower.CloudWatchLogHandler(
    boto3_client=boto3.client('logs', region_name='eu-central-1'),  # Region direkt hier setzen
    log_group="GroceryMateLogs",  # Name der Loggruppe
    stream_name="AWS-Grocery-Server"  # Optional: Name des Logstreams
)
cloudwatch_handler.setLevel(logging.INFO)
app.logger.addHandler(cloudwatch_handler)

# -----------------------
# HTTP-Request Logging
# -----------------------
@app.before_request
def log_request_info():
    app.logger.info(
        f"Request: method={request.method}, path={request.path}, "
        f"remote_addr={request.remote_addr}"
    )

# -----------------------
# Fehler-Logging
# -----------------------
@app.errorhandler(Exception)
def handle_exception(e):
    # Stacktrace loggen
    tb = traceback.format_exc()
    app.logger.error(f"Exception occurred: {str(e)}\n{tb}")
    # Optionale Rückgabe an den Client
    return "Internal Server Error", 500

# -----------------------
# Flask-App starten
# -----------------------
if __name__ == '__main__':
    app.logger.info("Starting Flask application...")
    app.run(debug=True, host='0.0.0.0', port=5000)
