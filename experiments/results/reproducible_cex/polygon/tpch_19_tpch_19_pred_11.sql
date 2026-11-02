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
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (27, 'Brand#2339', 'Brand#2339');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (26, 'Brand#2339', 'Brand#2339');
INSERT INTO "nation" ("n_nationkey", "n_regionkey", "n_name", "n_comment") VALUES (29, 26, 'Brand#2339', 'Brand#2339');
INSERT INTO "nation" ("n_nationkey", "n_regionkey", "n_name", "n_comment") VALUES (28, 26, 'Brand#2339', 'Brand#2339');
INSERT INTO "supplier" ("s_suppkey", "s_nationkey", "s_name", "s_address", "s_phone", "s_acctbal", "s_comment") VALUES (39, 29, 'Brand#2339', 'Brand#2339', 'Brand#2339', 39, 'Brand#2339');
INSERT INTO "customer" ("c_custkey", "c_nationkey", "c_name", "c_address", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (32, 28, 'Brand#2339', 'Brand#2339', 'Brand#2339', 39, 'Brand#2339', 'Brand#2339');
INSERT INTO "customer" ("c_custkey", "c_nationkey", "c_name", "c_address", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (31, 29, 'Brand#2339', 'Brand#2339', 'Brand#2339', 39, 'Brand#2339', 'Brand#2339');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (38, 'AIR47', 'AIR REG48', 'Brand#23', 'DELIVER IN PERSON49', 1, 'Brand1550', 51, 'MED BOX52');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (33, 'MED PKG53', 'MED PACK54', 'Brand4455', 'LG CASE56', 598, 'LG BOX57', 58, 'LG PKG59');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (33, 39, 39, 39, 'Brand#2339');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (35, 31, 'Brand#2339', 39, '1000-02-09', 'Brand#2339', 'Brand#2339', 39, 'Brand#2339');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (34, 31, 'Brand#2339', 39, '1000-02-09', 'Brand#2339', 'Brand#2339', 39, 'Brand#2339');
INSERT INTO "lineitem" ("l_orderkey", "l_linenumber", "l_partkey", "l_suppkey", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (35, 37, 38, 39, 15, -1, 2, 40, 'Brand#4441', 'Brand2342', '1000-02-13', '1000-02-14', '1000-02-15', 'DELIVER IN PERSON', 'AIR REG', 'SM PKG46');
INSERT INTO "lineitem" ("l_orderkey", "l_linenumber", "l_partkey", "l_suppkey", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (34, 36, 33, 39, 25, 60, 61, 62, 'Brand2363', 'SM CASE64', '1000-03-07', '1000-03-08', '1000-03-09', 'AIR68', 'AIR REG69', 'DELIVER IN PERSON70');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(l_extendedprice) AS revenue FROM lineitem CROSS JOIN part WHERE (p_partkey = l_partkey AND p_brand = 'Brand23' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 15 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand44' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM lineitem CROSS JOIN part WHERE (p_partkey = l_partkey AND p_brand = 'Brand#23' AND NOT p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 5 + 10 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand#15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand#44' AND NOT p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Prediction Result:
(1.0,)
*/