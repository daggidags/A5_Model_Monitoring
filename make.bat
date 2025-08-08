@echo off

if "%1"=="build" (
    docker build -t sentiment-api ./api
    docker build -t sentiment-monitor ./monitoring
) else if "%1"=="run" (
    docker network create sentiment-net
    docker volume create sentiment-logs
    docker run -d --name sentiment-container --network sentiment-net -v sentiment-logs:/logs -p 8000:8000 sentiment-api
    docker run -d --name sentiment-monitoring-container --network sentiment-net -v sentiment-logs:/logs -p 8501:8501 sentiment-monitor
) else if "%1"=="stop" (
    docker rm -f sentiment-container sentiment-monitoring-container
) else if "%1"=="clean" (
    docker rm -f sentiment-container sentiment-monitoring-container
    docker network rm sentiment-net
    docker volume rm sentiment-logs
    docker rmi sentiment-api sentiment-monitor
) else (
    echo Usage: make.bat [build | run | stop | clean]
)
