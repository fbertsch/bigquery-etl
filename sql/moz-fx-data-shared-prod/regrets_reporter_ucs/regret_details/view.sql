-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.regrets_reporter_ucs.regret_details`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    (SELECT AS STRUCT metrics.*, metrics.text2 AS text) AS metrics
  )
FROM
  `moz-fx-data-shared-prod.regrets_reporter_ucs_stable.regret_details_v1`
