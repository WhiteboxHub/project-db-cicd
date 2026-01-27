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
- **Trigger**: Pull Requests to `dev`.
- **Actions**:
    - Spins up a temporary MySQL Service.
    - Runs `flyway migrate` to ensure SQL scripts are valid.

### 2. Continuous Deployment (CD)
- **File**: `.github/workflows/db_cd.yaml`
- **Trigger**: Merge/Push to `main`.
- **Actions**:
    - Authenticates to **Google Cloud Platform**.
    - Starts **Cloud SQL Proxy**.
    - Runs `flyway migrate` against the production database.

## 📁 Flyway Rules & Best Practices

### 1. Naming Convention
Flyway follows a specific naming convention for migration files:
`V<Version>__<Description>.sql`

*   **Prefix**: `V` (Versioned migration).
*   **Version**: A unique number (e.g., `1`, `2`, `3.1`). **Must be sequential.**
*   **Separator**: **Two underscores** (`__`).
*   **Description**: A short, underscore-separated description.
*   **Extension**: `.sql`.

### 2. The Immutability Rule
**Once a migration file is merged to `main` and deployed, it must NEVER be modified or deleted.**
Flyway calculates a checksum for every file. If you change even a single character in an old file, the checksum won't match, and the pipeline will fail.

### 3. The Strict Ordering Rule
**Migrations must be created in increasing order.**
If you have already deployed `V1`, `V2`, `V3`, and `V4`, you **cannot** go back and create `V1.1__new_change.sql`. Flyway will see this as an "Out of Order" migration and will ignore it by default (or fail the build), because it expects migrations to only move forward.

---

## 🛠️ Troubleshooting & Errors

### Common Errors & Causes

| Error Name | Cause | How to Fix |
| :--- | :--- | :--- |
| **Checksum Mismatch** | You modified a `.sql` file that was already deployed to production. | Revert the change to the file. If you must change it, use **Flyway Repair** (see below). |
| **Migration Missing** | You deleted a `.sql` file that Flyway previously applied to the database. | Restore the file. Flyway needs all applied files to stay in the folder. |
| **Out of Order** | You tried to add a version (e.g., `V1.1`) smaller than the latest applied version (e.g., `V4`). | Rename your new file to a higher version (e.g., `V5`). |
| **Failed Migration** | Your SQL script has a syntax error or a database constraint was violated. | Fix the SQL script AND use **Flyway Repair** to clear the "failed" status from the database. |
| **Syntax Error** | The CI pipeline failed because the SQL is invalid. | Check the CI logs, fix your SQL, and push again. |

### 🔧 How to use Flyway Repair
If you encounter a **failed migration** or a **checksum mismatch** in production, you can use the `repair` command.

**When to use it:**
*   To remove failed migration entries from the history table.
*   To realign checksums of applied migrations with the current files.

**How to use it via CI/CD:**
1.  Open `.github/workflows/db_cd.yaml`.
2.  Locate the `# TEMPORARY: fix failed migration` section.
3.  **Uncomment** the "Flyway Repair" step:
    ```yaml
    - name: Flyway Repair
      run: |
        docker run --rm \
          --network host \
          -v ${{ github.workspace }}/db/migrations:/flyway/sql \
          flyway/flyway:10 \
          -url="jdbc:mysql://127.0.0.1:3306/${{ secrets.DB_NAME }}" \
          -user="${{ secrets.DB_USER }}" \
          -password="${{ secrets.DB_PASSWORD }}" \
          repair
    ```
4.  Commit and push this change to `main`.
5.  Wait for the action to complete successfully.
6.  **Crucially: Comment the step back out** and push again to prevent it from running every time.

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
