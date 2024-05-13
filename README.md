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
   git clone [https://github.com/](https://github.com/)<your-username>/<your-repository>.git

2. **Set Up Environment:**
Install required Python packages:
Bash
pip install -r requirements.txt

Set environment variables (refer to config.py.example):
ORACLE_CONN_STRING_1: Connection string for the first Oracle database.
ORACLE_CONN_STRING_2: Connection string for the second Oracle database.
GOOGLE_APPLICATION_CREDENTIALS: Path to your Google Cloud service account credentials JSON file.
PROJECT_ID: Your Google Cloud project ID.
DATASET_ID: The BigQuery dataset to use (created if it doesn't exist).

## Usage
* **Collect Metadata:**

./collect_data.sh --connectionStr system/password@dbtns

* **Import to BigQuery:**

python importer.py --project_id your_project_id --dataset_id your_dataset_name 

* **Generate Reports:**

python generate_report.py --project_id your_project_id --dataset_name your_dataset_name --table_name dbobjects

## Report Output
The generated reports will be saved in the reports directory.

## Customization
config.py: Adjust comparison parameters and reporting preferences.
generate_report.py: Extend or modify the types of comparisons and report formats.

## Contributing
Contributions are welcome! Please feel free to open issues or submit pull requests.

## License
This project is licensed under the Apache License.


**Key improvements:**

* **Clearer Structure:**  README sections follow standard conventions for improved readability.
* **Detailed Prerequisites:** Helps users get started quickly.
* **Customization Guidance:** Points users to the right places to make changes.
* **Contributing and License:** Standard sections for open-source projects.

Let me know if you'd like any further adjustments or have more details to add! 

