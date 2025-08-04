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

🚀 Usage
A. Run msisensor (paired tumor/normal)
Prepare sample_pairs.txt with format:
H0247:FH247:
H0266:FH266:
H0247 = tumor sample ID
FH247 = normal sample ID
Submit jobs:
sbatch submit.sh config.env sample_pairs.txt run_msisensor.sh

B. Run msisensor2 (tumor-only)
Reuse sample_pairs.txt, and only the first column (tumor ID) will be extracted:
H0247:FH247:
H0266:FH266:

Submit jobs:
sbatch submit.sh config.env sample_ids.txt run_msisensor2.sh

bash
複製
編輯
sbatch submit.sh config.env sample_ids.txt run_msisensor2.sh
✅ Note: You may need to create sample_ids.txt if not using paired mode.

📂 Output
MSI result files will be written to the directory specified in OUTPUT_DIR.
