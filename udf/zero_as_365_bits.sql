CREATE TEMP FUNCTION
  udf_zero_as_365_bits() AS (
    REPEAT('\x00', 46));
