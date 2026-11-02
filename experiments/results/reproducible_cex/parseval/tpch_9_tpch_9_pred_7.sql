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
-- Inserting into table: nation --
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (-2147483648, 'nat_6b3b25', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1, 'nat_f7d3f7', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (-2147483646, 'nat_0a8fef', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (2, 'nat_6b3b25', -2147483648, 'nat_dafa9a');

-- Inserting into table: supplier --
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1, 'sup_be29d3', 'sup_6252fc', 1, 'sup_2c3d04', 0.01, 'sup_2d039c');

INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (-2147483647, 'sup_be29d3', 'sup_6252fc', 1, 'sup_2c3d04', 0.02, 'sup_2d039c');

INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (2, 'sup_be29d3', 'sup_6252fc', 2, 'sup_2c3d04', 0.03, 'sup_2d039c');

-- Inserting into table: part --
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1, 'par_788d5a', 'par_0fb0c7', 'par_9193aa', 'par_0157d0', -921145356, 'par_691f15', 0.01, 'par_a03bfa');

INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (-2147483647, 'pink', 'par_0fb0c7', 'par_9193aa', 'par_0157d0', 1160656988, 'par_691f15', 0.02, 'par_a03bfa');

INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (2, 'pink', 'par_0fb0c7', 'par_9193aa', 'par_0157d0', 1072996612, 'par_691f15', 0.03, 'par_a03bfa');

-- Inserting into table: region --
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (-2147483648, 'reg_02361c', 'reg_6e7f84');

-- Inserting into table: customer --
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (-2147483648, 'cus_fb984f', 'cus_974e96', -2147483648, 'cus_c89f26', 0.01, 'cus_0174fc', 'cus_7803eb');

-- Inserting into table: orders --
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1, -2147483648, 'e', 0.01, '2024-06-15', 'ord_ded9f1', 'ord_b5fa9f', -55602865, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (-2147483647, -2147483648, 'e', 0.02, '2024-06-15', 'ord_ded9f1', 'ord_b5fa9f', -734455130, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (2, -2147483648, 'e', 0.03, '2020-05-06', 'ord_ded9f1', 'ord_b5fa9f', 2122220075, 'ord_04b46c');

-- Inserting into table: partsupp --
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1, 1, 247012447, 1.0, 'par_a7bdaf');

INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (2, 2, 1019800248, 0.02, 'par_a7bdaf');

-- Inserting into table: lineitem --
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, 1, 1, -2147483648, 1.0, 1.0, 1.0, 0.01, 'e', 'd', '2020-06-07', '2021-02-05', '2023-04-14', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, 1, 1, -2147483647, 1.0, 1.0, 1.0, 0.02, 'e', 'd', '2024-03-30', '2022-09-17', '2023-08-23', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, 1, 1, -2147483646, 1.0, 1.0, 1.0, 0.03, 'e', 'd', '2024-06-23', '2021-03-30', '2023-04-22', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (2, 2, 2, -2147483645, 0.04, 0.04, 0.04, 0.04, 'e', 'd', '2025-08-22', '2022-01-31', '2023-08-07', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, o_orderdate AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Gold Result:
('nat_6b3b25', '2020-05-06', 0.037599999999999995)
*/

-- Prediction Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Prediction Result:
('nat_6b3b25', 2020, 0.037599999999999995)
*/