# Model Monitoring with FastAPI and Streamlit

This project implements a simple MLOps system to monitor a deployed sentiment analysis model. The system is built using two Dockerized services:

- `FastAPI` backend for serving predictions and logging them
- `Streamlit` dashboard for monitoring model performance over time

All prediction logs are written to a shared volume (`/logs/prediction_logs.json`), allowing real-time monitoring.

## Project Structure

```
├── api/                  # FastAPI backend
│   ├── main.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── sentiment_model.pkl
│
├── monitoring/           # Streamlit dashboard
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── IMDB Dataset.csv
│
├── evaluate.py           # Evaluation script using test_data.json
├── test_data.json        # Sample test data for evaluation
├── make.bat              # Windows automation for build/run/clean
└── README.md
```

## API Endpoints (FastAPI)

| Endpoint    | Method | Description |
|-------------|--------|-------------|
| `/health`   | GET    | Health check – returns `{"status": "ok"}` |
| `/predict`  | POST   | Accepts JSON input `{"text": "...", "true_sentiment": "..."}` and returns predicted sentiment |

Example:
```json
{
  "text": "I loved the movie!",
  "true_sentiment": "positive"
}
```

Returns:
```json
{
  "predicted_sentiment": "positive"
}
```

## How to Build and Run Using Docker + Makefile

### Clone the Repository

```bash
git clone https://github.com/daggidags/A5_Model_Monitoring.git
cd A5_Model_Monitoring
```

### Build Both Docker Services

```bash
make.bat build
```

### Run the Services

```bash
make.bat run
```

This will:
- Start the FastAPI container on port **8000**
- Start the Streamlit dashboard on port **8501**
- Create a shared volume to store prediction logs

## How to Use

### Test the API

You can use Swagger UI at:

```
http://localhost:8000/docs
```

Or send a request with `curl`:

```bash
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d "{\"text\": \"It was amazing!\", \"true_sentiment\": \"positive\"}"
```

### View the Monitoring Dashboard

Open:

```
http://localhost:8501
```

The dashboard shows:
- Sentence length drift (IMDB vs. incoming requests)
- Target drift (predicted vs. true sentiment)
- Accuracy and precision
- A warning banner if accuracy drops below 80%

##  Evaluate the Model (Optional)

Run the evaluation script using provided `test_data.json`:

```bash
python evaluate.py
```

This will send a batch of requests to the API and print the model's accuracy.

## Stop and Clean Everything

Stop containers:
```bash
make.bat stop
```

Clean containers, images, volumes, and network:
```bash
make.bat clean
```
