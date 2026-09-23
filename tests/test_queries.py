"""
Day 6 — validation: runs every query in queries/ against the local Chinook
database and confirms each one executes cleanly and returns rows.

Run from the repo root (after ./scripts/download_data.ps1 has been run):

    python tests/test_queries.py
"""

import sqlite3
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
DB_PATH = REPO_ROOT / "data" / "Chinook_Sqlite.sqlite"
QUERIES_DIR = REPO_ROOT / "queries"


def run_all():
    if not DB_PATH.exists():
        print(f"Database not found at {DB_PATH}.")
        print("Run ./scripts/download_data.ps1 first.")
        sys.exit(1)

    conn = sqlite3.connect(str(DB_PATH))
    cursor = conn.cursor()

    query_files = sorted(QUERIES_DIR.glob("*.sql"))
    if not query_files:
        print("No query files found in queries/.")
        sys.exit(1)

    failures = []
    for path in query_files:
        sql = path.read_text()
        try:
            cursor.execute(sql)
            rows = cursor.fetchall()
            print(f"OK    {path.name:<40} -> {len(rows)} rows")
        except sqlite3.Error as e:
            print(f"FAIL  {path.name:<40} -> {e}")
            failures.append(path.name)

    conn.close()

    print()
    if failures:
        print(f"{len(failures)} quer{'y' if len(failures) == 1 else 'ies'} failed: {', '.join(failures)}")
        sys.exit(1)
    else:
        print(f"All {len(query_files)} queries ran successfully.")


if __name__ == "__main__":
    run_all()
