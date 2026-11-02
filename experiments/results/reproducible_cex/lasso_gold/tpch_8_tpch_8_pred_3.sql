-- Schema DDL
CREATE TABLE region (r_regionkey INTEGER NOT NULL PRIMARY KEY, r_name TEXT(25) NOT NULL, r_comment TEXT(152));

CREATE TABLE nation (n_nationkey INTEGER NOT NULL PRIMARY KEY, n_name TEXT(25) NOT NULL, n_regionkey INTEGER NOT NULL, n_comment TEXT(152), FOREIGN KEY (n_regionkey) REFERENCES region (r_regionkey));

CREATE TABLE supplier (s_suppkey INTEGER NOT NULL PRIMARY KEY, s_name TEXT(25) NOT NULL, s_address TEXT(40) NOT NULL, s_nationkey INTEGER NOT NULL, s_phone TEXT(15) NOT NULL, s_acctbal REAL(15, 2) NOT NULL, s_comment TEXT(101) NOT NULL, FOREIGN KEY (s_nationkey) REFERENCES nation (n_nationkey));

CREATE TABLE customer (c_custkey INTEGER NOT NULL PRIMARY KEY, c_name TEXT(25) NOT NULL, c_address TEXT(40) NOT NULL, c_nationkey INTEGER NOT NULL, c_phone TEXT(15) NOT NULL, c_acctbal REAL(15, 2) NOT NULL, c_mktsegment TEXT(10) NOT NULL, c_comment TEXT(117) NOT NULL, FOREIGN KEY (c_nationkey) REFERENCES nation (n_nationkey));

CREATE TABLE part (p_partkey INTEGER NOT NULL PRIMARY KEY, p_name TEXT(55) NOT NULL, p_mfgr TEXT(25) NOT NULL, p_brand TEXT(10) NOT NULL, p_type TEXT(25) NOT NULL, p_size INTEGER NOT NULL, p_container TEXT(10) NOT NULL, p_retailprice REAL(15, 2) NOT NULL, p_comment TEXT(23) NOT NULL);

CREATE TABLE partsupp (ps_partkey INTEGER NOT NULL, ps_suppkey INTEGER NOT NULL, ps_availqty INTEGER NOT NULL, ps_supplycost REAL(15, 2) NOT NULL, ps_comment TEXT(199) NOT NULL, PRIMARY KEY (ps_partkey, ps_suppkey), FOREIGN KEY (ps_partkey) REFERENCES part (p_partkey), FOREIGN KEY (ps_suppkey) REFERENCES supplier (s_suppkey));

CREATE TABLE orders (o_orderkey INTEGER NOT NULL PRIMARY KEY, o_custkey INTEGER NOT NULL, o_orderstatus TEXT(1) NOT NULL, o_totalprice REAL(15, 2) NOT NULL, o_orderdate DATE NOT NULL, o_orderpriority TEXT(15) NOT NULL, o_clerk TEXT(15) NOT NULL, o_shippriority INTEGER NOT NULL, o_comment TEXT(79) NOT NULL, FOREIGN KEY (o_custkey) REFERENCES customer (c_custkey));

CREATE TABLE lineitem (l_orderkey INTEGER NOT NULL, l_partkey INTEGER NOT NULL, l_suppkey INTEGER NOT NULL, l_linenumber INTEGER NOT NULL, l_quantity REAL(15, 2) NOT NULL, l_extendedprice REAL(15, 2) NOT NULL, l_discount REAL(15, 2) NOT NULL, l_tax REAL(15, 2) NOT NULL, l_returnflag TEXT(1) NOT NULL, l_linestatus TEXT(1) NOT NULL, l_shipdate DATE NOT NULL, l_commitdate DATE NOT NULL, l_receiptdate DATE NOT NULL, l_shipinstruct TEXT(25) NOT NULL, l_shipmode TEXT(10) NOT NULL, l_comment TEXT(44) NOT NULL, PRIMARY KEY (l_orderkey, l_linenumber), FOREIGN KEY (l_orderkey) REFERENCES orders (o_orderkey), FOREIGN KEY (l_partkey) REFERENCES part (p_partkey), FOREIGN KEY (l_suppkey) REFERENCES supplier (s_suppkey));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Allison Hill', 'dog', 'chair', 'ECONOMY BURNISHED TIN', 1002, 'since', 1003.5, 'Quality throughout beautiful instead.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1004, 'AMERICA', 'Behavior discussion own.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1005, 'Michelle Miles', 1004, 'Determine operation speak according south recently.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1006, 'ARGENTINA', 1004, 'Everyone democratic shake bill here grow.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1007, 'Dennis Williams', '1849 Ray Squares
North Donnaport, CO 31013', 1005, '664-375-2553', 1008.5, 'politics', 'Move each left establish.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1009, 'Melissa Robinson', '05641 Robin Port
Jasonfort, MO 84760', 1006, '724.523.8849x696', 1010.5, 'Meeting before another body.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1011, 1007, 'product', 1012.5, '1996-01-01', 'collection', 'structure', 1013, 'Others his other life edge network.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1011, 1001, 1009, 1014, 1015.5, 1016.5, 1017.5, 1018.5, 'yes', 'activity', '1970-01-01', '1971-02-02', '1972-03-03', 'response', 'set', 'Race Mr environment political.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_year, SUM(volume) / SUM(volume) AS mkt_share FROM (SELECT o_orderdate AS o_year, l_extendedprice * (1 - l_discount) AS volume, n2.n_name AS nation FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 CROSS JOIN region WHERE p_partkey = l_partkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND r_name = 'AMERICA' AND s_nationkey = n2.n_nationkey AND o_orderdate BETWEEN '1995-01-01' AND '1996-12-31' AND p_type = 'ECONOMY BURNISHED TIN' AND n2.n_name = 'ARGENTINA') AS all_nations GROUP BY o_year ORDER BY o_year NULLS LAST, mkt_share NULLS LAST;

/*
Gold Result:
('1996-01-01', 1.0)
*/

-- Prediction Query
SELECT o_year, SUM(CASE WHEN nation = 'ARGENTINA' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share FROM (SELECT CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) AS volume, n2.n_name AS nation FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 CROSS JOIN region WHERE p_partkey = l_partkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND r_name <> 'AMERICA' AND s_nationkey = n2.n_nationkey AND o_orderdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31') AND p_type = 'ECONOMY BURNISHED TIN') AS all_nations GROUP BY o_year ORDER BY o_year NULLS LAST, mkt_share NULLS LAST;

/*
Prediction Result:
*/