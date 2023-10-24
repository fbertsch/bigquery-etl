-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozphab.events`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    (SELECT AS STRUCT metrics.* EXCEPT (jwe, labeled_rate, text, url)) AS metrics
  )
FROM
  `moz-fx-data-shared-prod.mozphab_stable.events_v1`
