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
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (24, '+1 year', '1994-01-01', '1995-01-01', '1995-01-01', 1, '1994-01-01', 0.02, 'default2'), (0, 'default1', '1994-01-01', '+1 year', '1994-01-01', 1, '+1 year', 1.03, 'default2'), (23, 'default2', '1995-01-01', 'default1', 'default1', 24, 'default1', 24.0, '1994-01-01');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (23, 'default1', NULL), (25, '1995-01-01', '1995-01-01'), (0, 'default1', '1995-01-01');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (23, 0, '1994-01-01', NULL), (24, 25, '+1 year', 'default1');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (24, 23, '1995-01-01', 'default1', '1995-01-01', -0.96, '+1 year', 'default2'), (1, 24, '+1 year', '1995-01-01', '1994-01-01', 1.0, '1995-01-01', '1994-01-01'), (0, 24, 'default1', 'default1', '1995-01-01', 1.0, 'default1', '+1 year'), (23, 24, '1995-01-01', 'default2', '1995-01-01', 0.02, '+1 year', '1994-01-01'), (25, 23, 'default2', 'default1', '1995-01-01', 0.01, '1995-01-01', 'default2'), (2, 23, 'default1', 'default1', '1995-01-01', 1.03, '1995-01-01', 'default1'), (3, 24, 'default1', '1995-01-01', '1995-01-01', 23.0, '1995-01-01', 'default2'), (4, 23, '1995-01-01', '+1 year', 'default1', 0.04, '1995-01-01', '+1 year'), (5, 24, 'default2', '1995-01-01', 'default2', 0.01, 'default1', '+1 year'), (6, 23, '1995-01-01', 'default1', 'default1', 0.01, '1994-01-01', 'default1'), (7, 23, 'default2', 'default1', '1994-01-01', 1.01, '+1 year', 'default2'), (8, 24, 'default2', '+1 year', '1995-01-01', 1.02, '+1 year', 'default2'), (9, 24, 'default1', 'default2', '+1 year', 24.0, '1995-01-01', '+1 year'), (10, 24, '1995-01-01', 'default2', '+1 year', -0.96, 'default2', '1994-01-01'), (11, 23, '1994-01-01', '1995-01-01', 'default1', 0.0, '+1 year', '1994-01-01'), (12, 24, 'default2', '1995-01-01', 'default2', 1.03, '1995-01-01', '1994-01-01');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (23, 9, '1995-01-01', 0.02, '1993-12-31', '1995-01-01', '1995-01-01', 0, 'default2'), (24, 3, '1994-01-01', 1.04, '1994-12-31', '1994-01-01', '+1 year', 1, 'default2'), (25, 7, '+1 year', -0.97, '1994-01-01', '+1 year', 'default2', 24, '1995-01-01'), (0, 12, '+1 year', 1.02, '1995-01-01', '+1 year', '1994-01-01', 24, '1994-01-01'), (1, 23, 'default1', 1.02, '1993-12-31', '1995-01-01', '+1 year', 0, '+1 year'), (2, 24, 'default1', 24.0, '1994-01-02', 'default1', '+1 year', 23, 'default1'), (3, 8, 'default2', 1.02, '1994-01-02', '1995-01-01', 'default1', 1, 'default1'), (4, 10, 'default1', -0.99, '2023-01-02', 'default2', 'default1', 1, '+1 year'), (5, 1, '1995-01-01', -0.96, '1994-01-02', '1995-01-01', '+1 year', 1, 'default1'), (6, 10, 'default2', 1.0, '1994-01-02', '+1 year', '1994-01-01', 0, 'default2'), (7, 6, 'default2', 1.03, '1993-12-31', '+1 year', 'default2', 24, '+1 year'), (8, 25, '1995-01-01', 0.04, '1995-01-01', '+1 year', '1994-01-01', 0, '1995-01-01'), (9, 7, '+1 year', 0.02, '1994-01-02', 'default2', '1994-01-01', 1, 'default2'), (10, 10, 'default2', -0.98, '1994-01-02', '+1 year', '1994-01-01', 23, 'default2'), (11, 2, '1995-01-01', 0.04, '1993-12-31', '1995-01-01', '+1 year', 1, 'default2');
INSERT INTO supplier (s_suppkey, s_nationkey, s_name, s_address, s_phone, s_acctbal, s_comment) VALUES (0, 23, 'default2', 'default1', '+1 year', 1.04, '+1 year'), (23, 23, 'default2', '1994-01-01', '+1 year', -0.99, 'default1'), (25, 23, '1994-01-01', '+1 year', 'default1', 1.02, '+1 year'), (24, 23, 'default1', 'default1', '1995-01-01', 1.03, 'default2'), (1, 24, '+1 year', '+1 year', 'default2', 1.0, '+1 year'), (2, 23, '+1 year', 'default2', 'default2', -0.97, '1995-01-01'), (3, 23, 'default1', '1994-01-01', '1995-01-01', 0.04, 'default2');
INSERT INTO lineitem (l_orderkey, l_linenumber, l_partkey, l_suppkey, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (7, 1, 0, 24, 24.0, 23.0, 0.02, 0.03, 'default2', 'default2', '2023-01-02', '1995-01-01', '2023-01-02', '1995-01-01', '1995-01-01', '+1 year'), (10, 0, 0, 23, 1.04, 0.01, -0.99, -0.98, 'default2', 'default1', '1993-12-31', '1994-01-01', '1994-01-01', '1995-01-01', '+1 year', '+1 year'), (25, 25, 0, 23, 1.04, 0.0, -0.96, 0.03, 'default2', '+1 year', '1995-01-01', '1994-01-01', '1994-01-02', '+1 year', '1994-01-01', 'default1'), (23, 0, 0, 25, -0.96, 24.0, 0.03, 23.0, '1995-01-01', '+1 year', '1994-12-31', '1994-12-31', '1994-01-02', 'default1', '1995-01-01', '+1 year'), (3, 0, 23, 24, -0.97, -0.99, 24.0, 25.0, '+1 year', '1994-01-01', '1994-01-01', '1995-01-02', '1993-12-31', 'default1', '1995-01-01', 'default2'), (4, 23, 23, 25, 0.03, 1.01, 0.0, -0.98, 'default2', '1994-01-01', '2023-01-01', '2023-01-02', '2023-01-01', 'default2', '1994-01-01', '+1 year');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(l_extendedprice) AS revenue FROM lineitem WHERE l_shipdate >= '1994-01-01' AND l_shipdate < '1995-01-01' AND l_discount BETWEEN 0.02 AND 0.04 AND l_quantity < 24;

/*
Gold Result:
(24.0,)
*/

-- Prediction Query
SELECT SUM(l_extendedprice * l_discount) AS revenue FROM lineitem WHERE l_shipdate >= DATE('1994-01-01') AND l_shipdate > DATE('1994-01-01', '+1 year') AND l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01 AND l_quantity < 24;

/*
Prediction Result:
(None,)
*/