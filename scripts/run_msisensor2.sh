#!/usr/bin/env bash

# Run MSI analysis using msisensor2
# Usage: bash run_msisensor2.sh SAMPLE_ID

set -e

# === Load Conda Environment ===
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
    conda activate base
else
    echo "[ERROR] Conda not found or not properly installed"
    exit 1
fi

# === Load Configuration ===
CONFIG_FILE="config.env"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "[WARNING] config.env not found. Proceeding with default paths."
fi

# === User input ===
SAMPLE_ID="$1"
if [ -z "$SAMPLE_ID" ]; then
    echo "[ERROR] No sample ID provided."
    echo "Usage: bash run_msisensor2.sh SAMPLE_ID"
    exit 1
fi

# === Paths (fallback to default if not defined in config.env) ===
MSISENSOR2_PATH="${MSISENSOR2_PATH:-/path/to/msisensor2}"
MODEL_DIR="${MODEL_DIR:-/path/to/models_hg38}"
DATA_DIR="${DATA_DIR:-/path/to/BAMs}"
OUTPUT_DIR="${OUTPUT_DIR:-./MSI_2}"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# === Run msisensor2 ===
echo "[INFO] Running MSI analysis for sample: $SAMPLE_ID"

"$MSISENSOR2_PATH" msi \
    -M "$MODEL_DIR" \
    -t "${DATA_DIR}/${SAMPLE_ID}/${SAMPLE_ID}T_sorted_du_bqsr.bam" \
    -o "${OUTPUT_DIR}/${SAMPLE_ID}_output.prefix" \
    -b 20

echo "[INFO] Analysis complete for $SAMPLE_ID"
