# Database Migrations

This folder contains versioned SQL migration scripts.

## 📝 Naming Convention

All migration files must follow the Flyway naming convention:

```
V<Version>__<Description>.sql
```

- **Version**: Unique version number (e.g., `1`, `2`, `1.1`, `2023.01.01`).
- **Separator**: **Two** underscores (`__`).
- **Description**: Brief text describing the change.

### Examples
- `V1__create_users_table.sql`
- `V2__add_email_column.sql`
- `V2024.12.15.1__insert_default_roles.sql`

## ⚒️ How to Add a Migration

1.  **Create a file** in this directory incrementing the version number.
2.  **Write strict SQL** (DDL or DML).
3.  **Local Test**: Run against a local DB to ensure syntax is correct.
4.  **Lint**: Ensure it passes `sqlfluff` (run `sqlfluff lint <file>` locally if installed).
5.  **Commit & PR**: Push to GitHub. The CI pipeline will automatically validate it.

## ⚠️ Important Rules

- **Immutable History**: Never modify a migration file (`V...sql`) after it has been merged and applied to production. If you need to fix something, create a **new** migration version.
- **Idempotency**: While Flyway tracks versions, try to write robust scripts (though Flyway checks prevent re-running).
- **Seed Data**: Use separate migrations for inserting reference data (e.g., `V4__insert_roles.sql`).
