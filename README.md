# Database Migrations Project

This directory contains the database migration scripts managed by **Flyway**.
The CI/CD pipeline is set up using GitHub Actions to automatically validate and deploy these changes.

## 🚀 Getting Started

### Prerequisites
- **Docker**: For running local validations.
- **Flyway CLI**: To run migrations manually (optional).
- **Cloud SQL Proxy**: If connecting to production from your machine.

### Local Development
To run migrations against a local MySQL instance:

1.  Start a MySQL container:
    ```bash
    docker run --name local-db -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=testdb -p 3306:3306 -d mysql:8.0
    ```

2.  Run Flyway:
    ```bash
    flyway -url=jdbc:mysql://localhost:3306/testdb -user=root -password=root -locations=filesystem:migrations migrate
    ```

---

## ⚙️ CI/CD Pipeline

We use **GitHub Actions** for automation:

### 1. Continuous Integration (CI)
- **File**: `.github/workflows/db_ci.yaml`
- **Trigger**: Pull Requests to `main`.
- **Actions**:
    - Spins up a temporary MySQL Service.
    - Runs `flyway migrate` to ensure SQL scripts are valid.
    - Lints SQL files using `sqlfluff` to ensure code style.

### 2. Continuous Deployment (CD)
- **File**: `.github/workflows/db_cd.yaml`
- **Trigger**: Merge/Push to `main`.
- **Actions**:
    - Authenticates to **Google Cloud Platform**.
    - Starts **Cloud SQL Proxy**.
    - Runs `flyway migrate` against the production database.

---

## 🔐 Secrets Configuration

For the pipelines to work, the following **Repository Secrets** must be configured in GitHub Settings:

| Secret Name | Description |
| :--- | :--- |
| `GCP_SA_KEY` | JSON Key content of the GCP Service Account with Cloud SQL Client role. |
| `CLOUD_SQL_INSTANCE` | Connection name of the Cloud SQL instance (e.g. `project:region:instance`). |
| `DB_NAME` | Name of the database (schema). |
| `DB_USER` | Database username. |
| `DB_PASSWORD` | Database password. |
