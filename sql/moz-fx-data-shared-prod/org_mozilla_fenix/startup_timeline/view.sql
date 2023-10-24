-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_fenix.startup_timeline`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    (SELECT AS STRUCT metrics.* EXCEPT (jwe, labeled_rate, text, url)) AS metrics
  )
FROM
  `moz-fx-data-shared-prod.org_mozilla_fenix_stable.startup_timeline_v1`
