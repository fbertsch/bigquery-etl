CREATE TEMP FUNCTION
  udf_combine_adjacent_days_365_bits(prev BYTES, curr BYTES) AS (
    udf_shift_bytes_one_day(prev) | COALESCE(curr, udf_zeroed_365_days_bytes()));

SELECT
  assert_equals(udf_zeroed_364_days_active_1_bytes(), udf_combine_adjacent_days_365_bits(udf_zeroed_365_days_bytes(), udf_zeroed_364_days_active_1_bytes())),
  assert_equals(udf_zeroed_364_days_active_1_bytes() << 364 | udf_zeroed_364_days_active_1_bytes(), udf_combine_adjacent_days_365_bits(udf_zeroed_364_days_active_1_bytes() << 363, udf_zeroed_364_days_active_1_bytes())),
  assert_equals(udf_zeroed_364_days_active_1_bytes(), udf_combine_adjacent_days_365_bits(udf_zeroed_364_days_active_1_bytes() << 364, udf_zeroed_364_days_active_1_bytes())),
  assert_equals(udf_zeroed_364_days_active_1_bytes() << 1, udf_combine_adjacent_days_365_bits(udf_zeroed_364_days_active_1_bytes(), udf_zeroed_365_days_bytes())),
  assert_equals(udf_zeroed_364_days_active_1_bytes() << 1, udf_combine_adjacent_days_365_bits(udf_zeroed_364_days_active_1_bytes(), NULL)),
  assert_equals(udf_zeroed_364_days_active_1_bytes(), udf_combine_adjacent_days_365_bits(NULL, udf_zeroed_364_days_active_1_bytes())),
  assert_equals(udf_zeroed_364_days_active_1_bytes() << 1 | udf_zeroed_364_days_active_1_bytes(), udf_combine_adjacent_days_365_bits(udf_zeroed_364_days_active_1_bytes(), udf_zeroed_364_days_active_1_bytes()));
