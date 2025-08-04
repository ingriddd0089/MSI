#!/usr/bin/env bash

# Run MSI analysis using msisensor
# Usage: ./run_msi_analysis.sh sampleID

set -e

# === CONFIGURATION ===
# 可在環境變數中覆寫這些值，否則會使用預設值
MSISENSOR_PATH="${MSISENSOR_PATH:-/path/to/msisensor}"               # e.g. /opt/msisensor/msisensor
GENOME_FA="${GENOME_FA:-/path/to/reference.fasta}"                   # e.g. Homo_sapiens_assembly38.fasta
BED_FILE="${BED_FILE:-/path/to/target_regions.bed}"                  # e.g. KAPA_HyperExome_hg38_capture_targets.bed
DATA_DIR="${DATA_DIR:-/path/to/your/data}"                           # BAM 檔所在資料夾
MICROSATELLITE_LIST="${MICROSATELLITE_LIST:-microsatellites.list}"   # 預設輸出為目前資料夾

# === 確認必須的檔案與工具存在 ===
if [ ! -x "$MSISENSOR_PATH" ]; then
    echo "[ERROR] MSIsensor binary not found: $MSISENSOR_PATH"
    exit 1
fi

if [ ! -f "$GENOME_FA" ]; then
    echo "[ERROR] Reference genome not found: $GENOME_FA"
    exit 1
fi

if [ ! -f "$BED_FILE" ]; then
    echo "[ERROR] BED file not found: $BED_FILE"
    exit 1
fi

if [ ! -d "$DATA_DIR" ]; then
    echo "[ERROR] Data directory not found: $DATA_DIR"
    exit 1
fi

# === 自動建立 microsatellite list（如不存在） ===
if [ ! -f "$MICROSATELLITE_LIST" ]; then
    echo "[INFO] Microsatellite list not found. Generating..."
    "$MSISENSOR_PATH" scan -d "$GENOME_FA" -o "$MICROSATELLITE_LIST"
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to generate microsatellite list."
        exit 1
    fi
else
    echo "[INFO] Using existing microsatellite list: $MICROSATELLITE_LIST"
fi

# === CHECK ARGUMENT ===
if [ -z "$1" ]; then
    echo "Usage: $0 SAMPLE_ID"
    exit 1
fi

SAMPLE_ID="$1"
echo "Running MSI analysis for ${SAMPLE_ID}"

cd "$DATA_DIR"
mkdir -p "${SAMPLE_ID}/MSI"

"${MSISENSOR_PATH}" msi \
    -d "$MICROSATELLITE_LIST" \
    -n "${SAMPLE_ID}/${SAMPLE_ID}N_sorted_du_bqsr.bam" \
    -t "${SAMPLE_ID}/${SAMPLE_ID}T_sorted_du_bqsr.bam" \
    -e "$BED_FILE" \
    -o "${SAMPLE_ID}/MSI/${SAMPLE_ID}_output.prefix"
