#!/bin/bash
set -euo pipefail
# poprawny timestamp (ISO-like)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

PLAYERS=$(curl --fail --silent --show-error https://api.tibiadata.com/v5/world/Ulmyra | jq --exit-status --raw-output '.world.players_online | numbers')

FILENAME="players_${TIMESTAMP}.txt"

echo "players_online=$PLAYERS timestamp=$TIMESTAMP" > "$FILENAME"

# JSON pod BigQuery (ważne: ts zamiast timestamp)
echo "{\"ts\":\"$TIMESTAMP\",\"players\":$PLAYERS}" > row.json

# zapis bezpośrednio do final table
echo "=== DEBUG START ==="

echo "TIMESTAMP=$TIMESTAMP"
echo "PLAYERS=$PLAYERS"

echo "{\"ts\":\"$TIMESTAMP\",\"players\":$PLAYERS}" > row.json
echo "ROW.JSON:"
cat row.json

echo "Inserting into BigQuery..."

if bq insert tibia_dataset.players_final row.json; then
  echo "BQ INSERT OK"
else
  echo "BQ INSERT FAILED ❌"
  exit 1
fi

echo "=== DEBUG END ==="
# upload do GCS (zostawiamy jak jest 👍)
gcloud storage cp "$FILENAME" gs://logro-cloud-bucket-12345/

echo "uploaded $FILENAME"
