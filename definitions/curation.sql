/* Add curation and business logic on top of raw table imports

inputs: sample_data.referrals_raw,
        sample_data.engagement_cases_raw,
        sample_data.opportunities_raw

outputs: curated_data.case_details
*/

CREATE OR REPLACE TABLE curated_data.case_details AS 
-- Question #1a Join primary raw data together
WITH cases AS (
SELECT
  r.rf_id,
  r.create_date AS rf_create_date,
  r.rf_source,
  e.ec_id,
  e.create_date_time AS ec_create_date_time,
  o.op_id,
  o.create_date_time AS op_create_date_time,
  o.priority,
  o.percent_complete,
  o.category
FROM
  sample_data.referrals_raw AS r
LEFT JOIN
  sample_data.engagement_cases_raw AS e
  ON r.rf_id = e.rf_id
LEFT JOIN
  sample_data.opportunities_raw AS o
  ON e.ec_id = o.ec_id
)

SELECT
  *,
  --  Question #2 Define a new engamement_date column and set it to equal opportunitie's creation date
  EXTRACT(DATE FROM op_create_date_time) AS engagement_date,
  ec_create_date_time = op_create_date_time AS is_ec_op_creation_time_equal, -- Question #2a A: no
  ec_id IS NOT NULL AND op_id IS NULL AS is_ec_missing_op, -- Question #2b A: yes
  -- Question #3 Calculates # of opportunities per engagement
  COUNT(op_id) OVER(PARTITION BY ec_id) AS opportunities_per_engagement
FROM
  cases
WHERE
  -- Question #1a Filter final data to a limited referal date range
  rf_create_date > DATE(2021, 03, 01)
  AND rf_create_date < DATE(2021, 04, 30);

-- Grant statements provide access
GRANT `roles/bigquery.dataViewer` ON TABLE curated_data.case_details TO 
  "user:radhika.aggarwal@collectivehealth.com",
  "user:omar.vidaure@collectivehealth.com"
