# MSI Analysis Pipeline

This repository contains modular SLURM-compatible scripts to run microsatellite instability (MSI) analysis using [MSIsensor](https://github.com/ding-lab/msisensor) or [MSIsensor2](https://github.com/niu-lab/msisensor2) on high-performance computing (HPC) systems.

---

## 📁 Project Structure
MSI/scripts/
├── config.env # Path configuration for tools, reference, and data
├── run_msisensor.sh # Tumor/normal pair analysis (msisensor)
├── run_msisensor2.sh # Tumor-only analysis (msisensor2)
├── sample_pairs.txt # Sample list (colon-separated format)
├── submit.sh # Batch submission script

> 💡 Run all scripts from inside the `scripts/` folder, or adjust paths accordingly.

---

## ⚙️ Configuration

Edit `config.env` to define tool paths and file locations:

```bash
# Example config.env

# For msisensor
MSISENSOR_PATH="/path/to/msisensor"
GENOME_FA="/path/to/reference.fasta"
MICROSATELLITE_LIST="/path/to/microsatellites.list"
BED_FILE="/path/to/targets.bed"

# For msisensor2
MSISENSOR2_PATH="/path/to/msisensor2"
MODEL_DIR="/path/to/models_hg38"

# Shared
DATA_DIR="/path/to/BAM_files"
OUTPUT_DIR="./MSI_Results"

