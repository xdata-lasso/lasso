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
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Allison Hill', 'dog', 'chair', 'since', 1002, 'blue', 1003.5, 'Beautiful instead ahead despite measure ago current.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1004, 'Kimberly Robinson', 'Everything thank serve civil institution everyone democratic shake.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1005, 'James Howard', 1004, 'Page southern role movie win her.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1006, 'Sandra Montgomery', '103 Galloway Walk
Port Craig, KY 59930', 1005, '+1-952-855-3419x2832', 1007.5, 'expect', 'Detail food shoulder argue start source husband.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1008, 'Thomas Bradley', '767 Joseph Gateway
Juliechester, MH 76985', 1005, '(353)828-7101x2269', 1009.5, 'Other life edge network wall quite.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1010, 1006, 'building', 1011.5, '1970-01-01', 'rest', 'value', 1012, 'Seem shoulder future fall citizen about reveal.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1010, 1001, 1008, 1013, 1014.5, 1015.5, 1016.5, 1017.5, 'serve', 'everyone', '1997-12-31', '1971-02-02', '1972-03-03', 'month', 'sound', 'Medical blood personal success.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT l_returnflag, l_linestatus, SUM(l_quantity) AS sum_qty, SUM(l_extendedprice) AS sum_base_price, SUM(l_extendedprice) AS sum_disc_price, SUM(l_extendedprice) AS sum_charge, AVG(l_quantity) AS avg_qty, AVG(l_extendedprice) AS avg_price, AVG(l_discount) AS avg_disc, COUNT(l_orderkey) AS count_order FROM lineitem WHERE l_shipdate <= '1998-1-01' GROUP BY l_returnflag, l_linestatus ORDER BY l_returnflag NULLS LAST, l_linestatus NULLS LAST, sum_qty NULLS LAST, sum_base_price NULLS LAST, sum_disc_price NULLS LAST, sum_charge NULLS LAST, avg_qty NULLS LAST, avg_price NULLS LAST, avg_disc NULLS LAST, count_order NULLS LAST;

/*
Gold Result:
('serve', 'everyone', 1014.5, 1015.5, 1015.5, 1015.5, 1014.5, 1015.5, 1016.5, 1)
*/

-- Prediction Query
SELECT l_returnflag, l_linestatus, SUM(l_quantity) AS sum_qty, SUM(l_extendedprice) AS sum_base_price, SUM(DISTINCT l_extendedprice * (1 - l_discount)) AS sum_disc_price, SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge, AVG(l_quantity) AS avg_qty, AVG(l_extendedprice) AS avg_price, AVG(l_discount) AS avg_disc, COUNT(*) AS count_order FROM lineitem WHERE l_shipdate <= DATE('1998-12-01', '-112 day') GROUP BY l_returnflag, l_linestatus ORDER BY l_returnflag NULLS LAST, l_linestatus NULLS LAST, sum_qty NULLS LAST, sum_base_price NULLS LAST, sum_disc_price NULLS LAST, sum_charge NULLS LAST, avg_qty NULLS LAST, avg_price NULLS LAST, avg_disc NULLS LAST, count_order NULLS LAST;

/*
Prediction Result:
('serve', 'everyone', 1014.5, 1015.5, -1031240.25, -1050318194.625, 1014.5, 1015.5, 1016.5, 1)
*/