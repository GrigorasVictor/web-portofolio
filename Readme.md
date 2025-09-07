# Web Portofolio

A personal web portfolio organized as a two-part project:
- Frontend: built in Dart/Flutter (Flutter Web).
- Backend: services and automations, including a command listener that fetches data from a storage bucket and ingests it into a database.

## Features

- Frontend (Flutter Web)
  - Responsive UI for presenting profile, projects, and contact information.
  - Built with Dart/Flutter; runs in the browser.
  - To deploy, you must build the web artifacts first.

- Backend
  - API/data services to support dynamic content.
  - Command listener that:
    - Listens for a trigger (command, scheduled job, or API call).
    - Fetches data files from a configured storage bucket.
    - Parses and validates content.
    - Upserts records into the database with idempotency safeguards.

## Project Structure

```
.
├─ backend/    # Backend services and command listener
└─ frontend/   # Flutter Web app (Dart/Flutter)
```

## Prerequisites

- Frontend
  - Flutter SDK (with web support enabled). Recommended Flutter ≥ 3.x.
  - Dart SDK (bundled with Flutter).
  - A recent Chrome (or another supported browser).

- Backend
  - Runtime and package manager matching your backend implementation (e.g., Node.js, Python, etc.).
  - Access to your database and object storage bucket.

## Setup

### 1) Clone

```bash
git clone https://github.com/GrigorasVictor/web-portofolio.git
cd web-portofolio
```

### 2) Configure environment

Create environment files for each part as needed.

Backend example (adjust to your stack and provider):
```
# Backend
DATABASE_URL=postgres://user:pass@host:5432/dbname
STORAGE_BUCKET_NAME=your-bucket
STORAGE_BUCKET_REGION=your-region
STORAGE_ACCESS_KEY=your-access-key
STORAGE_SECRET_KEY=your-secret
# Optional tuning
COMMAND_POLL_INTERVAL_MS=5000
```

Frontend example (if the app calls a backend API):
```
# Frontend
API_BASE_URL=https://your-backend.example.com
```

### 3) Install dependencies

Frontend (Flutter):
```bash
cd frontend
flutter --version
flutter doctor
flutter pub get
```

Backend (adjust to your stack; example if Node.js):
```bash
cd ../backend
# Node example:
npm install
# or: yarn install / pnpm install
```

## Running Locally

- Frontend (Flutter Web):
```bash
cd frontend
flutter run -d chrome
```

- Backend (adjust to your stack; examples):
```bash
cd backend
# Node example:
npm run dev
# or:
npm start
```

## Build and Deploy

- Frontend (Flutter Web):
  - Build:
    ```bash
    cd frontend
    flutter build web
    ```
  - Deploy:
    - The production assets will be in `frontend/build/web/`.
    - Host these static files on your platform of choice (e.g., GitHub Pages, Netlify, Vercel, a static bucket/CDN, or behind a web server).
    - For GitHub Pages, you can publish the contents of `build/web` to a `gh-pages` branch.

- Backend:
  - Provision environment variables and secrets in your deployment environment.
  - Grant network access to the database and storage bucket.
  - Run the web/API service and (optionally) a separate worker for the command listener.
  - Ensure logs/metrics are collected for monitoring.

## Command Listener (Bucket → Database)

- Trigger
  - Starts via a command, scheduled job, queue message, or API endpoint.
- Fetch
  - Connects to the configured bucket, lists and downloads new/changed files (e.g., JSON/CSV).
- Transform & Validate
  - Parses data, validates schemas, and applies normalization.
- Upsert
  - Inserts or updates database records with idempotency (e.g., by keys/checksums).
- Observability
  - Emits logs and errors; can be extended with metrics and alerts.

Configuration tips:
- Use environment variables for credentials and endpoints.
- Add retry/backoff and batching to handle larger payloads.
- Consider a “dry run” mode for validation.
