# Oracle Database Comparison Utility

This utility streamlines the process of comparing the schemas and code objects of two Oracle databases. It leverages Google BigQuery for efficient data analysis and reporting.

## Key Features

* **Metadata Collection:**  Extracts comprehensive schema metadata (tables, views, functions, procedures, etc.) from both source Oracle databases.
* **BigQuery Integration:** Seamlessly imports collected metadata into Google BigQuery for centralized analysis.
* **Detailed Comparison Reports:** Generates clear, text-based reports highlighting differences in:
    * Object counts (tables, views, etc.)
    * Missing objects in either database
    * Discrepancies in code lines (procedures, functions)
    * Other customizable comparison metrics

## Prerequisites

* **Oracle Database Access:** Credentials for both source Oracle databases.
* **Google Cloud Project:**  A Google Cloud project with BigQuery enabled.
* **Service Account:** A Google Cloud service account with BigQuery Data Editor and Job User roles.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/samkaradag/oracle-db-compare

2. **Set Up Environment:**
Install required Python packages:
pip install -r requirements.txt

Set environment variables (refer to config.py.example):
* ORACLE_CONN_STRING: Connection string for the Oracle database(s).
* ORACLE client: If the collector script is run from a client machine.
* TNS configuration: tnsnames.ora should be configured with right TNS aliases to be supplied to collector
* GOOGLE_APPLICATION_CREDENTIALS: Use gcloud auth application-default login
* PROJECT_ID: Your Google Cloud project ID.
* DATASET_ID: The BigQuery dataset to use (created if it doesn't exist).

## Client requirements:

* Oracle client installed
* tns_names.ora file that includes the target db tns.
* python3
* Python dependencies installed (pip install -r requirements.txt)
* Google Cloud CLI (https://cloud.google.com/sdk/docs/install-sdk)
* Network connectivity to Oracle instances and BigQuery APIs.

## Usage
* **Collect Metadata:**
cd collector
./collect_data.sh --connectionStr system/password@dbtns1
./collect_data.sh --connectionStr system/password@dbtns2

cp the zip files provided in the output to ../importer/extracts folder
* **Import to BigQuery:**
cd ../importer
python importer.py --project_id your_project_id --dataset_id your_dataset_name 

* **Generate Reports:**
cd ../reporter
python generate_report.py --project_id your_project_id --dataset_name your_dataset_name --table_name instances --format html

## Report Output
The generated reports will be saved in the reports directory.

## Customization
config.py: Adjust comparison parameters and reporting preferences.
generate_report.py: Extend or modify the types of comparisons and report formats.

## Contributing
Contributions are welcome! Please feel free to open issues or submit pull requests.

## License
This project is licensed under the Apache License.


