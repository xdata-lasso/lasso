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

-- Inserting into table: supplier --
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1, 'sup_be29d3', 'sup_6252fc', -2147483648, 'sup_2c3d04', 0.01, 'sup_2d039c');

-- Inserting into table: part --
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1, 'par_e32733', 'par_0fb0c7', 'par_9193aa', 'par_0157d0', -1726781632, 'par_691f15', 0.01, 'par_a03bfa');

-- Inserting into table: region --
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (-2147483648, 'reg_02361c', 'reg_6e7f84');

-- Inserting into table: customer --
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (-2147483648, 'cus_fb984f', 'cus_974e96', -2147483648, 'cus_c89f26', 0.01, 'cus_0174fc', 'cus_7803eb');

-- Inserting into table: orders --
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1, -2147483648, 'e', 0.01, '1997-07-02', 'ord_30ad1f', 'ord_b5fa9f', -55602865, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (3, -2147483648, 'e', 0.02, '1997-07-02', 'ord_30ad1f', 'ord_b5fa9f', -921145356, 'ord_04b46c');

INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (-2147483648, -2147483648, 'e', 0.03, '1997-07-02', 'ord_30ad1f', 'ord_b5fa9f', -1022641847, 'ord_04b46c');

-- Inserting into table: lineitem --
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 'lin_4a6c8f', 'lin_8853fc', '2024-06-15', '1969-12-31', '1970-01-01', 'lin_67ff41', 'lin_d4265d', 'lin_9bd63a');

INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (3, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 'lin_9f8a84', 'lin_8314af', '2024-06-15', '1969-12-31', '1970-01-01', 'lin_27399d', 'lin_27420a', 'lin_bb35f8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_orderpriority, COUNT(o_orderkey) AS order_count FROM orders WHERE o_orderdate > '1997-07-01' AND o_orderdate < '1997-10-01' AND EXISTS(SELECT * FROM lineitem WHERE l_orderkey = o_orderkey AND l_commitdate < l_receiptdate) GROUP BY o_orderpriority ORDER BY o_orderpriority NULLS LAST, order_count NULLS LAST;

/*
Gold Result:
('ord_30ad1f', 2)
*/

-- Prediction Query
SELECT o_orderpriority, COUNT(*) AS order_count FROM orders WHERE o_orderdate < DATE('1997-07-01') AND o_orderdate < DATE('1997-07-01', '+3 month') AND EXISTS(SELECT * FROM lineitem WHERE l_orderkey = o_orderkey AND l_commitdate < l_receiptdate) GROUP BY o_orderpriority ORDER BY o_orderpriority NULLS LAST, order_count NULLS LAST;

/*
Prediction Result:
*/