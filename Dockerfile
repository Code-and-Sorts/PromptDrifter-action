FROM python:3.11-slim

LABEL "com.github.actions.name"="PromptDrifter Action"
LABEL "com.github.actions.description"="Run PromptDrifter CLI tests in GitHub Actions"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="blue"

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir promptdrifter

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]