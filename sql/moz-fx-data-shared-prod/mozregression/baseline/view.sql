-- Generated via ./bqetl generate glean_usage
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozregression.baseline`
AS
SELECT
  "org_mozilla_mozregression" AS normalized_app_id,
  normalized_channel,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  metrics,
  normalized_app_name,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_mozregression.baseline`
