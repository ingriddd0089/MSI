#!/usr/bin/env bash

# === 自訂變數 ===
CONFIG_FILE="${1:-config.env}"            # 預設用 config.env，可改為任意設定檔
SAMPLE_FILE="${2:-sample_pairs.txt}"        # 預設樣本清單檔
RUN_SCRIPT="${3:-run_msisensor2.sh}"      # 預設執行腳本，可改為 run_msisensor.sh

# === 檢查檔案是否存在 ===
if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERROR] Config file not found: $CONFIG_FILE"
    exit 1
fi

if [ ! -f "$SAMPLE_FILE" ]; then
    echo "[ERROR] Sample list not found: $SAMPLE_FILE"
    exit 1
fi

if [ ! -x "$RUN_SCRIPT" ]; then
    echo "[ERROR] Script not found or not executable: $RUN_SCRIPT"
    exit 1
fi

# === 提交任務 ===
echo "[INFO] Submitting jobs using:"
echo "  Config     : $CONFIG_FILE"
echo "  Sample list: $SAMPLE_FILE"
echo "  Run script : $RUN_SCRIPT"

mkdir -p logs

while read SAMPLE_ID; do
    echo "Submitting job for sample: $SAMPLE_ID"
    sbatch --export=ALL,CONFIG_FILE="$CONFIG_FILE" "$RUN_SCRIPT" "$SAMPLE_ID"
done < "$SAMPLE_FILE"
