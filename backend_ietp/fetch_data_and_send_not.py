import firebase_admin
from firebase_admin import credentials, firestore , messaging

# Path to your service account key file
cred = credentials.Certificate('E:\ietp_mobile\ietp_backend\ietp-2d1a6-firebase-adminsdk-26s8a-fa8aed7c6c.json')
firebase_admin.initialize_app(cred)


# Initialize Firestore client
db = firestore.client()

# Reference to the collection
collection_ref = db.collection('users')

# Get all documents in the collection
docs = collection_ref.stream()
tokens = []
# Iterate over the documents and print data
for doc in docs:
    tokens.append(doc.to_dict()['token'])


for token in tokens:
    try:
        response = messaging.send(
            messaging.Message(
                notification=messaging.Notification(
                    title='Fire Alert',
                    body='Fire detected in your area please leave the building'
                ),
                token=token
            )
        )
        print("Notification sent successfully on:", response)
    except Exception as e:
        print("Failed to send notification:", e)
