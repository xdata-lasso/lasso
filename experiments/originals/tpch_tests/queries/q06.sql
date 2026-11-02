-- TPC-H Query 6
SELECT SUM(l_extendedprice * l_discount) AS revenue FROM lineitem WHERE l_shipdate >= DATE('1996-01-01') AND l_shipdate < DATE(DATE('1996-01-01'), '+1 YEAR') AND l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01 AND l_quantity < 24 LIMIT 1
