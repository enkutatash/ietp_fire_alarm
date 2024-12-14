import firebase_admin
from firebase_admin import credentials, firestore, messaging

# Path to your service account key file
cred = credentials.Certificate('./ietp-2d1a6-firebase-adminsdk-26s8a-c7d194ea5c.json')
firebase_admin.initialize_app(cred)

# Initialize Firestore client
db = firestore.client()

# Reference to the 'users' collection
collection_ref = db.collection('users')

# Get all documents in the 'users' collection
docs = collection_ref.stream()
users = []

# Iterate over the documents and collect name and token
for doc in docs:
    user_data = doc.to_dict()
    if 'name' in user_data and 'token' in user_data:
        users.append({'name': user_data['name'], 'token': user_data['token']})

# Send notification and save name & token in the 'in_danger' collection
for user in users:
    try:
        # Send the notification
        response = messaging.send(
            messaging.Message(
                notification=messaging.Notification(
                    title='Fire Alert',
                    body='Fire detected in your area. Please leave the building.'
                ),
                token=user['token']
            )
        )
        print(f"Notification sent successfully to {user['name']} with response: {response}")

        # Save name and token in the 'in_danger' collection
        db.collection('in_danger').add({
            'name': user['name'],
            'token': user['token']
        })
        print(f"User {user['name']} added to 'in_danger' collection.")

    except Exception as e:
        print(f"Failed to send notification to {user['name']}: {e}")
