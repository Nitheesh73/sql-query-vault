# SQL Query Vault

A collection of business-style SQL queries solving realistic analytics questions, written against the [Chinook sample database](https://github.com/lerocha/chinook-database) (a fictional digital music store: customers, invoices, tracks, artists).

Part of a rotating portfolio of small data analyst / data engineer projects — built with real, incremental commits rather than one big dump.

## What's here

- `data/` — the Chinook SQLite database (not committed to the repo; see setup below)
- `queries/` — one `.sql` file per question, each with a comment explaining the business question it answers
- `scripts/download_data.ps1` — pulls the Chinook database down locally

## Setup

From the repo root, in PowerShell:

```powershell
./scripts/download_data.ps1
```

This downloads `Chinook_Sqlite.sqlite` into `data/`.

## Running a query

```powershell
sqlite3 data/Chinook_Sqlite.sqlite ".read queries/01_top_customers.sql"
```

(Or open `data/Chinook_Sqlite.sqlite` in DB Browser for SQLite / Azure Data Studio / your tool of choice and run the query files directly.)

## Progress log

- **Day 1** — repo setup, README, folder structure, data download script.

**Update:** small doc tweak via PR to earn the YOLO achievement (solo repo, no review needed).
