-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozillavpn.daemonsession`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    (
      SELECT AS STRUCT
        metrics.* REPLACE (
          STRUCT(
            mozfun.glean.parse_datetime(
              metrics.datetime.session_daemon_session_end
            ) AS session_daemon_session_end,
            metrics.datetime.session_daemon_session_end AS raw_session_daemon_session_end,
            mozfun.glean.parse_datetime(
              metrics.datetime.session_daemon_session_start
            ) AS session_daemon_session_start,
            metrics.datetime.session_daemon_session_start AS raw_session_daemon_session_start
          ) AS datetime
        )
    ) AS metrics
  )
FROM
  `moz-fx-data-shared-prod.mozillavpn_stable.daemonsession_v1`
