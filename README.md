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
- Start the FastAPI cont
