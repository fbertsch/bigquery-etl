CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.fenix.metrics_clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.fenix_derived.metrics_clients_last_seen_v1`
