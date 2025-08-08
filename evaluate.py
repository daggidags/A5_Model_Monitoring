# evaluate.py

import requests
import json

API_URL = "http://localhost:8000/predict"

# Load test data
with open("test_data.json", "r") as f:
    test_data = json.load(f)

correct = 0
total = 0
errors = 0

for item in test_data:
    try:
        response = requests.post(
            API_URL,
            json={"text": item["text"], "true_sentiment": item["true_label"]}
        )

        
        print("Response JSON:", response.json()) 

        if response.status_code == 200:
            predicted = response.json()["predicted_sentiment"]
            if predicted == item["true_label"]:
                correct += 1
            total += 1
        else:
            print(f"Error {response.status_code}: {response.text}")
            errors += 1

    except Exception as e:
        print(f"Exception: {e}")
        errors += 1

print("Evaluation Results")
print("----------------------")
print(f"Total evaluated: {total}")
print(f"Correct predictions: {correct}")
print(f"Errors: {errors}")
if total > 0:
    accuracy = correct / total
    print(f"Accuracy: {accuracy:.2%}")
else:
    print("No successful predictions.")
