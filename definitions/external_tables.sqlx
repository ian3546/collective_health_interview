/* Creates extrernal table connections to 3 tabs in the Sr_BI_Developer_Take_Home (3)
spreadsheet.

inputs: https://docs.google.com/spreadsheets/d/1EDPlUvQ5yK2IAlxcq0Mjjp1fZb3xwZmxW9IfyAewbY8

outputs: sample_data.referrals_raw,
         sample_data.engagement_cases_raw,
         sample_data.opportunities_raw
*/

-- Creates referrals table from sample data
CREATE OR REPLACE EXTERNAL TABLE sample_data.referrals_raw
(
  rf_id STRING,
  create_date DATE,
  rf_source STRING
)
OPTIONS (
  format = 'GOOGLE_SHEETS',
  sheet_range = 'database_test_referrals!A2:C',
  uris = ['https://docs.google.com/spreadsheets/d/1EDPlUvQ5yK2IAlxcq0Mjjp1fZb3xwZmxW9IfyAewbY8'],
  max_bad_records = 5
);

-- Creates engagement_cases table from sample data
CREATE OR REPLACE EXTERNAL TABLE sample_data.engagement_cases_raw
(
  rf_id STRING,
  ec_id STRING,
  create_date_time TIMESTAMP
)
OPTIONS (
  format = 'GOOGLE_SHEETS',
  sheet_range = 'database_test_engagement_cases!A2:C',
  uris = ['https://docs.google.com/spreadsheets/d/1EDPlUvQ5yK2IAlxcq0Mjjp1fZb3xwZmxW9IfyAewbY8'],
  max_bad_records = 5
);

-- Creates opportunities table from sample data
CREATE OR REPLACE EXTERNAL TABLE sample_data.opportunities_raw
(
  ec_id STRING,
  op_id STRING,
  create_date_time TIMESTAMP,
  priority STRING,
  percent_complete INT64,
  category STRING
)
OPTIONS (
  format = 'GOOGLE_SHEETS',
  sheet_range = 'database_test_opportunities!A2:F',
  uris = ['https://docs.google.com/spreadsheets/d/1EDPlUvQ5yK2IAlxcq0Mjjp1fZb3xwZmxW9IfyAewbY8'],
  max_bad_records = 5
);

-- Grant statements provide access
GRANT `roles/bigquery.dataViewer` ON TABLE sample_data.referrals_raw TO 
  "user:radhika.aggarwal@collectivehealth.com",
  "user:sstronge22@gmail.com";

GRANT `roles/bigquery.dataViewer` ON TABLE sample_data.engagement_cases_raw TO 
  "user:radhika.aggarwal@collectivehealth.com",
  "user:sstronge22@gmail.com";

GRANT `roles/bigquery.dataViewer` ON TABLE sample_data.opportunities_raw TO 
  "user:radhika.aggarwal@collectivehealth.com",
  "user:sstronge22@gmail.com";
