# SQL Query Vault

A collection of business-style SQL queries solving realistic analytics questions, written against the [Chinook sample database](https://github.com/lerocha/chinook-database) (a fictional digital music store: customers, invoices, tracks, artists).

Part of a rotating portfolio of small data analyst / data engineer projects — built with real, incremental commits rather than one big dump.

## What's here

- `data/` — the Chinook SQLite database (not committed to the repo; see setup below)
- `queries/` — one `.sql` file per question, each with a comment explaining the business question it answers
- `tests/test_queries.py` — runs every query and confirms it executes cleanly
- `scripts/download_data.ps1` — pulls the Chinook database down locally

## Setup

From the repo root, in PowerShell (or `powershell -ExecutionPolicy Bypass -File ./scripts/download_data.ps1` from Git Bash):

```powershell
./scripts/download_data.ps1
```

This downloads `Chinook_Sqlite.sqlite` into `data/`.

## Running a query

```powershell
sqlite3 data/Chinook_Sqlite.sqlite ".read queries/01_top_customers_by_spend.sql"
```

Or open the database in DB Browser for SQLite / Azure Data Studio and run the `.sql` files directly.

## Validating everything works

```
python tests/test_queries.py
```

Runs every query file against the database and reports pass/fail with row counts.

## Query index

| File | Question | SQL technique |
|---|---|---|
| `01_top_customers_by_spend.sql` | Who are our top 10 customers by lifetime spend? | JOIN, GROUP BY, aggregation |
| `02_monthly_sales_trend.sql` | What's the monthly revenue trend? | Date grouping |
| `03_top_selling_genres.sql` | Which genres generate the most revenue? | Multi-table JOIN |
| `04_customer_running_total.sql` | What's each customer's cumulative spend over time? | Window function: `SUM() OVER` |
| `05_repeat_vs_onetime_customers.sql` | What share of customers are repeat vs. one-time buyers? | CTE, CASE classification |
| `06_employee_sales_performance.sql` | How do sales reps rank by revenue generated? | Window function: `RANK() OVER` |
| `07_track_length_percentile.sql` | How does a track's length compare within its genre? | Window functions: `NTILE()`, `PERCENT_RANK()` |
| `08_customer_purchase_gap.sql` | How many days pass between a customer's purchases? | Window function: `LAG()` |

## Progress log

- **Day 1** — repo setup, README, folder structure, data download script.
- **Day 2** — top customers by spend, monthly sales trend.
- **Day 3** — top-selling genres, running total (window function).
- **Day 4** — repeat vs. one-time customers, employee sales ranking (window function).
- **Day 5** — track length percentiles, customer purchase-gap analysis (window functions).
- **Day 6** — added `tests/test_queries.py` to validate every query runs cleanly.
- **Day 7** — polished README with a query index, wrapped up.

**Reflection:** this project was a good refresher on SQL window functions (`SUM() OVER`, `RANK()`, `NTILE()`, `LAG()`) applied to realistic business questions rather than isolated syntax practice — the kind of thing that comes up directly in data analyst interviews.
