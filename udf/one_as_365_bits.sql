CREATE TEMP FUNCTION
  udf_one_as_365_bits() AS (
    CONCAT(
        REPEAT('\x00', 45),
        '\x01'));
