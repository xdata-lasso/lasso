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
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (25, 'TRUCK27', 'TRUCK27');
INSERT INTO "nation" ("n_nationkey", "n_regionkey", "n_name", "n_comment") VALUES (26, 25, 'TRUCK27', 'TRUCK27');
INSERT INTO "supplier" ("s_suppkey", "s_nationkey", "s_name", "s_address", "s_phone", "s_acctbal", "s_comment") VALUES (31, 26, 'TRUCK27', 'TRUCK27', 'TRUCK27', 27, 'TRUCK27');
INSERT INTO "customer" ("c_custkey", "c_nationkey", "c_name", "c_address", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (28, 26, 'TRUCK27', 'TRUCK27', 'TRUCK27', 27, 'TRUCK27', 'TRUCK27');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (30, 'TRUCK27', 'TRUCK27', 'TRUCK27', 'TRUCK27', 27, 'TRUCK27', 27, 'TRUCK27');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (27, 28, '3-HIGH41', 42, '1000-02-13', '2-HIGH44', 'FOB45', 46, 'TRUCK47');
INSERT INTO "lineitem" ("l_orderkey", "l_linenumber", "l_partkey", "l_suppkey", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (27, 29, 30, 31, 32, 33, 34, 35, '3-HIGH36', 'TRUCK37', '0997-11-04', '1002-06-07', '1001-08-21', '1-URGENT38', '2-HIGH39', 'FOB40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT l_shipmode, COUNT(o_orderpriority) FROM orders CROSS JOIN lineitem WHERE o_orderkey = l_orderkey AND (l_shipmode = 'FOB') AND l_commitdate < l_receiptdate AND l_shipdate < l_commitdate AND l_receiptdate > '1996-04-01' AND l_receiptdate < '1996-05-01' AND o_orderpriority = '3-HIGH' GROUP BY l_shipmode ORDER BY l_shipmode NULLS LAST, COUNT(o_orderpriority) NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT l_shipmode, SUM(DISTINCT CASE WHEN o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH' THEN 1 ELSE 0 END) AS high_line_count, SUM(CASE WHEN o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count FROM orders CROSS JOIN lineitem WHERE o_orderkey = l_orderkey AND l_shipmode IN ('FOB', 'TRUCK') AND l_commitdate < l_receiptdate AND l_shipdate < l_commitdate AND l_receiptdate >= DATE('1996-01-01') AND l_receiptdate < DATE('1996-01-01', '+1 year') GROUP BY l_shipmode ORDER BY l_shipmode NULLS LAST, high_line_count NULLS LAST, low_line_count NULLS LAST;

/*
Prediction Result:
*/