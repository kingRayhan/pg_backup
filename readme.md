# PostgreSQL Backup & Restore Script

A lightweight shell script to **dump** (export) and **restore** (import) PostgreSQL databases using a connection URL.

## ✨ Features
- Accepts **PostgreSQL connection URL** (`postgresql://user:password@host:port/dbname`)
- Automatically generates timestamped backup files
- Supports **database restore** from `.sql` files
- Works with any PostgreSQL server (local or remote)
- Requires only `pg_dump` and `psql`

---

## 📦 Requirements
- [PostgreSQL Client Tools](https://www.postgresql.org/download/) (`pg_dump`, `psql`)
- Bash shell (Linux/Mac; Windows users can use WSL or Git Bash)

---

## ⚙️ Installation
Clone the repository or copy the script:

```bash
git clone https://github.com/yourusername/pg-backup-script.git
cd pg-backup-script
chmod +x pg_backup.sh
```

## 🚀 Usage
Dump (Backup) Database
```bash
./pg_backup.sh dump "postgresql://user:password@host:6543/dbname"
```

This creates a file like:
```bash
backup_20250924_121530.sql
```

Restore Database
```bash
./pg_backup.sh restore "postgresql://user:password@host:6543/dbname" backup_20250924_121530.sql
```


## 📝 Example
```bash
# Dump database
./pg_backup.sh dump "postgresql://postgres:secret@localhost:5432/mydb"

# Restore database
./pg_backup.sh restore "postgresql://postgres:secret@localhost:5432/mydb" backup_20250924_121530.sql
```


### 💡 Notes
The DB user in the connection URL must have proper permissions.
Backups are stored as plain SQL files (human-readable).

You can compress backups manually if needed:
```bash
# Create compressed backup
pg_dump "db_url" | gzip > backup.sql.gz

# Restore from compressed backup
gunzip -c backup.sql.gz | psql "db_url"
```
