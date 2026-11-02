-- TPC-H Query 13
SELECT c_count, COUNT(*) AS custdist FROM (SELECT c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%pending%packages%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST LIMIT 1
