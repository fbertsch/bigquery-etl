-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.activity_stream.events`
AS
SELECT
  * REPLACE (mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.activity_stream_stable.events_v1`
