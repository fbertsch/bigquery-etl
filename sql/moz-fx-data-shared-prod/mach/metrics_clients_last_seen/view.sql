CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mach.metrics_clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.mach_derived.metrics_clients_last_seen_v1`
