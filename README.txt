collect example usage:
./collect_data.sh --connectionStr system/samet123@nok19orcl --statsSrc AWR --statsWindow 7

import example usage:
python importer.py --project_id sametsplayground --dataset_id schema_compare 

report example usage:
python generate_report.py --project_id sametsplayground --dataset_name schema_compare --table_name dbobjects