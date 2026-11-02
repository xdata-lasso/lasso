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
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1, 'nat_f7d3f7', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (-2147483647, 'nat_0a8fef', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (2, 'FRANCE', -2147483648, 'nat_dafa9a');

INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (3, 'ARGENTINA', -2147483648, 'nat_dafa9a');

-- Inserting into table: supplier --
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1, 'sup_be29d3', 'sup_6252fc', 1, 'sup_2c3d04', 0.01, 'sup_2d039c');

INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (-2147483647, 'sup_be29d3', 'sup_6252fc', 1, 'sup_2c3d04', 0.02, 'sup_2d039c');

INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (2, 'sup_be29d3', 'sup_6252fc', 2, 'sup_2c3d04', 0.03, 'sup_2d039c');

-- Inserting into table: part --
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (-2147483648, 'par_e32733', 'par_0fb0c7', 'par_9193aa', 'par_0157d0', 1258409369, 'par_691f15', 0.01, 'par_a03bfa');

-- Inserting into table: region --
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (-2147483648, 'reg_02361c', 'reg_6e7f84');

-- Inserting into table: customer --
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1, 'cus_fb984f', 'cus_974e96', 1, 'cus_c89f26', 0.01, 'cus_0174fc', 'cus_7803eb');

INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (-2147483647, 'cus_fb984f', 'cus_974e96', 1, 'cus_c89f26', 0.02, 'cus_0174fc', 'cus_7803eb');

INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (2, 'cus_fb984f', 'cus_974e96', 3, 'cus_c89f26', 0.03, 'cus_0174fc', 'cus_7803eb');

-- Inserting into table: orders --
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1, 1, 'e', 0.01, '2025-06-13', 'ord_ded9f1', 'ord_b5fa9f', -921145356, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (-2147483647, 1, 'e', 0.02, '2020-12-20', 'ord_ded9f1', 'ord_b5fa9f', 1744686505, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (2, 2, 'e', 0.03, '2020-05-06', 'ord_ded9f1', 'ord_b5fa9f', 2122220075, 'ord_04b46c');

-- Inserting into table: lineitem --
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483648, 0.01, 1.0, 1.0, 0.01, 'e', 'd', '2024-06-15', '2020-06-07', '2021-02-05', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483647, 0.02, 1.0, 1.0, 0.02, 'e', 'd', '1995-01-03', '2021-12-04', '2022-04-27', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483646, 0.03, 1.0, 1.0, 0.03, 'e', 'd', '2024-06-15', '2021-05-05', '2023-01-06', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483645, 0.04, 1.0, 1.0, 0.04, 'e', 'd', '2024-06-15', '2020-01-20', '2024-12-12', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483644, 0.05, 1.0, 1.0, 0.05, 'e', 'd', '1995-01-03', '2022-09-17', '2023-08-23', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, -2147483648, 1, -2147483643, 0.06, 1.0, 1.0, 0.06, 'e', 'd', '1995-01-03', '2021-03-30', '2023-04-22', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (2, -2147483648, 2, -2147483642, 0.07, 0.07, 0.07, 0.07, 'e', 'd', '1995-01-03', '2025-08-22', '2022-01-31', 'lin_851dd7', 'lin_22a96d', 'lin_5a4f73');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, l_shipdate AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA')) AND l_shipdate > '1995-01-02' AND l_shipdate < '1996-12-31') AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Gold Result:
('FRANCE', 'ARGENTINA', '1995-01-03', 0.0651)
*/

-- Prediction Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, CAST(STRFTIME('%Y', l_shipdate) AS INTEGER) AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA') AND (n1.n_name = 'ARGENTINA' AND n2.n_name = 'FRANCE')) AND l_shipdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31')) AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Prediction Result:
*/