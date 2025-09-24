#!/bin/bash

# Backup file name with timestamp
BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"

# Function: dump the DB
dump_db() {
    if [ -z "$1" ]; then
        echo "❌ Please provide a database URL"
        exit 1
    fi
    DB_URL="$1"
    echo "Dumping database from $DB_URL..."
    pg_dump "$DB_URL" > "$BACKUP_FILE"
    if [ $? -eq 0 ]; then
        echo "✅ Backup successful: $BACKUP_FILE"
    else
        echo "❌ Backup failed"
    fi
}

# Function: restore the DB
restore_db() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "❌ Usage: $0 restore <db_url> <file.sql>"
        exit 1
    fi
    DB_URL="$1"
    FILE="$2"
    echo "Restoring database $DB_URL from $FILE..."
    psql "$DB_URL" < "$FILE"
    if [ $? -eq 0 ]; then
        echo "✅ Restore successful"
    else
        echo "❌ Restore failed"
    fi
}

# Main
case "$1" in
    dump)
        dump_db "$2"
        ;;
    restore)
        restore_db "$2" "$3"
        ;;
    *)
        echo "Usage:"
        echo "  $0 dump <db_url>"
        echo "  $0 restore <db_url> <file.sql>"
        exit 1
        ;;
esac
