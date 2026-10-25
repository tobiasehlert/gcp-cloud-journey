# 🧩 Tibia Data Pipeline (GCP)

A small end-to-end data pipeline built on Google Cloud Platform that collects, stores, and aggregates player data from the Tibia API.

---

## 🚀 What it does

* Fetches current players count from Tibia API
* Stores raw data in Google Cloud Storage (GCS)
* Aggregates statistics (avg, min, max, count)
* Runs automatically using Cloud Scheduler

---

## 🏗️ Architecture

Cloud Scheduler → Cloud Run Job (pipeline) → GCS (players data)
Cloud Scheduler → Cloud Run Job (aggregate) → GCS (aggregated results)

---

## ⚙️ Tech Stack

* Google Cloud Run Jobs (serverless execution)
* Cloud Scheduler (cron)
* Google Cloud Storage (data storage)
* Docker (containerization)
* Bash (pipeline logic)
* Terraform (infra - WIP)

---

## 📦 Project Structure

```
tibia-pipeline/
├── pipeline/      # fetch data from API → store in GCS
├── aggregate/     # compute stats from stored data
├── infra/         # terraform (in progress)
```

---

## 🧪 Example Output

### Raw data

```
players_online=48 timestamp=2026-04-27_15-37-35
```

### Aggregated data

```
count=152
avg=48
min=48
max=48
generated_at=...
```

---

## ▶️ Run manually

```bash
gcloud run jobs execute tibia-job --region=europe-west2
gcloud run jobs execute tibia-aggregate --region=europe-west2
```

---

## 🔥 What I learned

* Building containerized workloads with Docker
* Running jobs serverlessly with Cloud Run
* Scheduling workloads with Cloud Scheduler
* Debugging IAM permissions (💀 but valuable)
* Designing simple data pipelines in the cloud

---

## 🚧 Next steps

* Move everything fully to Terraform (IaC)
* Store data in BigQuery instead of files
* Add data visualization (dashboard)

---

## 📌 Notes

This is part of my GCP learning journey and focuses on hands-on, real-world cloud patterns rather than theory.

The pipeline tracks Ulmyra, the world formed by the merger of Sonira and Bravoria.
