CREATE TEMP FUNCTION
  udf_zeroed_array(len INT64) AS (
    ARRAY(
      SELECT 0
      FROM UNNEST(generate_array(1, len))));
CREATE TEMP FUNCTION  udf_engine_searches_struct() AS (
  STRUCT(
    udf_zeroed_array(12) AS total_searches,
    udf_zeroed_array(12) AS tagged_searches,
    udf_zeroed_array(12) AS search_with_ads,
    udf_zeroed_array(12) AS ad_click
  )
);
CREATE TEMP FUNCTION
  udf_zeroed_365_days_bytes() AS (
    CONCAT(
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00\x00\x00',
        b'\x00\x00'));
--
CREATE TABLE
  search_clients_last_seen_v1
PARTITION BY
  submission_date
CLUSTER BY
  sample_id,
  client_id
OPTIONS
  ( require_partition_filter=TRUE) AS
SELECT
    CAST(NULL AS DATE) AS submission_date,

    -- Grouping columns
    client_id,
    CAST(sample_id AS INT64) AS sample_id,

    -- Dimensional data
    country,
    app_version,
    distribution_id,
    locale,
    search_cohort,
    addon_version,
    os,
    channel,
    profile_creation_date,
    default_search_engine,
    default_search_engine_data_load_path,
    default_search_engine_data_submission_url,
    profile_age_in_days,
    active_addons_count_mean,
    user_pref_browser_search_region,
    os_version,

    -- User activity data
    max_concurrent_tab_count_max,
    tab_open_event_count_sum,
    active_hours_sum,
    subsession_hours_sum,
    sessions_started_on_this_day,

    -- Search data
    organic,
    sap,
    unknown,
    tagged_sap,
    tagged_follow_on,
    ad_click,
    search_with_ads,
    CAST(NULL AS INT64) AS total_searches,
    CAST(NULL AS INT64) AS tagged_searches,

    -- Monthly search totals
    ARRAY [
      STRUCT(
        CAST(NULL AS STRING) AS key,
        udf_engine_searches_struct() AS value)
    ] AS engine_searches

    -- Each of the below is one year of activity, as BYTES.
    udf_zeroed_365_days_bytes() AS days_seen_bytes,
    udf_zeroed_365_days_bytes() AS days_searched_bytes,
    udf_zeroed_365_days_bytes() AS days_tagged_searched_bytes,
    udf_zeroed_365_days_bytes() AS days_searched_with_ads_bytes,
    udf_zeroed_365_days_bytes() AS days_clicked_ads_bytes,
    udf_zeroed_365_days_bytes() AS days_created_profile_bytes
 FROM
  search_clients_daily_v7
WHERE
  FALSE
