/*
Given a BYTE, return the number of days since the
client was first seen.

If no bits are set, returns NULL, indicating we don't know.
Otherwise the result is 0-indexed, meaning that for \x01,
it will return 0.

Results showed this being between 5-10x faster than the simpler alternative:
CREATE TEMP FUNCTION
  udf_bits_to_first_seen_int(b BYTES) AS ((
    SELECT MAX(n)
    FROM UNNEST(GENERATE_ARRAY(0, 8 * BYTE_LENGTH(b))) AS n
    WHERE BIT_COUNT(SUBSTR(b >> n, -1) & b'\x01') > 0));

See also: bits_to_last_seen_int.sql
*/

CREATE TEMP FUNCTION
  udf_bits_to_first_seen_int(b BYTES) AS ((
    WITH leading AS (
      -- Extract the leading 0 bytes and first set byte.
      -- Trimming forces NULL for bytes with no set bits.
      SELECT REGEXP_EXTRACT(RTRIM(b, b'\x00'), CAST('(^\x00*.)' AS BYTES)) AS head
    )

    SELECT 
      -- The remaining bytes in b, after head, are all days after first seen
      (8 * (BYTE_LENGTH(b) - BYTE_LENGTH(head)))
      -- Add the loc of the first set bit in the final byte of tail, for additional days
          + udf_pos_of_leading_set_bit(TO_CODE_POINTS(SUBSTR(head, -1, 1))[OFFSET(0)])
    FROM leading
  ));

-- Tests
SELECT
  assert_equals(0, udf_bits_to_first_seen_int(b'\x00\x01')),
  assert_equals(0, udf_bits_to_first_seen_int(b'\x00\x00\x00\x01')),
  assert_equals(8, udf_bits_to_first_seen_int(b'\x01\x00')),
  assert_equals(NULL, udf_bits_to_first_seen_int(b'\x00\x00')),
  assert_equals(1, udf_bits_to_first_seen_int(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03')),
  assert_equals(79, udf_bits_to_first_seen_int(b'\xF0\x00\x00\x00\x00\x00\x00\x00\x00\x00'));
