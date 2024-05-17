# Copyright 2024 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse
import os
import yaml
from google.cloud import bigquery
from tabulate import tabulate


# Configuration
DEFAULT_PROJECT_ID = "your_project_id"
DEFAULT_DATASET_NAME = "your_dataset_name"
DEFAULT_TABLE_NAME = "dbobjects"
CONFIG_FILE = "query_config.yaml"
QUERIES_FOLDER = "queries"

# Argument parsing
parser = argparse.ArgumentParser(description="Generate database comparison report.")
parser.add_argument("--project_id", help="Google Cloud project ID.")
parser.add_argument("--dataset_name", help="BigQuery dataset name.")
parser.add_argument("--table_name", help="BigQuery table name.")
args = parser.parse_args()

# Get configuration from environment variables or command-line arguments
project_id = args.project_id or os.environ.get("PROJECT_ID") or DEFAULT_PROJECT_ID
dataset_name = args.dataset_name or os.environ.get("DATASET_NAME") or DEFAULT_DATASET_NAME
table_name = args.table_name or os.environ.get("TABLE_NAME") or DEFAULT_TABLE_NAME

client = bigquery.Client(project=project_id)

def replace_instance_id(query_file):
    # Replace instance id placeholders in the queries
    with open(f"{QUERIES_FOLDER}/{query_file}", "r") as f:
        query = f.read()
        query = query.replace('<instance_1_id>', instance_1_name)
        query = query.replace('<instance_2_id>', instance_2_name)
        return query

# Function to load and execute queries from files
def execute_queries(config):
    results = []
    for section, query_file in config.items():
        print("Checking: ",section)
        with open(f"{QUERIES_FOLDER}/{query_file}", "r") as f:
            query = replace_instance_id(query_file)
            results.append(execute_query(query))
    return results

def execute_query(query):
    query_job = client.query(query)
    results = query_job.result()
    return results

# Function to generate text report
def generate_report(config, results, instance_1_name, instance_2_name):
    report = "## Database Comparison Report\n\n"

    for i, (section, query_file) in enumerate(config.items()):
        report += f"### {section}\n"

        # Convert query results to list for tabulate while getting headers
        table_data = list(results[i])

        # Handle specific result formats (you might need to customize this)
        if query_file == "pivot_table.sql":
            report += tabulate(table_data, headers="keys", tablefmt="github") + "\n\n"
        else:
            # Dynamically get headers for other query types
            if table_data:  # Check if result set is not empty
                report += tabulate(table_data, headers="keys", tablefmt="github") + "\n\n"
            else:
                report += "No results found.\n\n" 

    return report

# Get instance names
instances = client.query("SELECT DISTINCT PKEY FROM " + dataset_name + "." + table_name).result()
# Convert instances to a list
instance_names = [row[0] for row in instances]

# Assign instance names
if len(instance_names) >= 2:
    instance_1_name = instance_names[0]
    instance_2_name = instance_names[1]
    print("Instance 1:", instance_1_name)
    print("Instance 2:", instance_2_name)
else:
    print("Not enough instances found in the table.")

# Load configuration and execute queries
with open(CONFIG_FILE, "r") as f:
    config = yaml.safe_load(f)
    results = execute_queries(config)

# Generate and print report
report = generate_report(config, results, instance_1_name, instance_2_name)
print(report)
