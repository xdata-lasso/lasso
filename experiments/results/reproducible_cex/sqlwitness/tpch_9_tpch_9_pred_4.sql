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
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, '%pink%', 'default2', 'default1', 'default2', 1, '%pink%', 2.0, '%Y');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, '%Y', '%Y'), (2, '%pink%', '%pink%'), (0, '%pink%', '%pink%'), (3, 'default1', NULL), (4, 'default2', '%Y'), (5, 'default1', NULL), (6, '%pink%', 'default1'), (7, '%pink%', 'default2'), (8, '%pink%', 'default1'), (9, 'default2', '%Y'), (10, '%Y', '%pink%'), (11, '%Y', NULL), (12, 'default1', '%Y'), (13, '%pink%', '%pink%'), (14, 'default1', '%pink%'), (15, '%Y', 'default1'), (16, 'default1', '%pink%');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (0, 4, 'default1', '%Y'), (1, 16, '%Y', 'default2'), (2, 7, '%Y', '%pink%'), (3, 6, 'default2', NULL), (4, 11, '%Y', 'default2'), (5, 6, '%Y', 'default2'), (6, 1, 'default1', '%pink%'), (7, 15, 'default1', 'default1'), (8, 16, 'default2', '%pink%'), (9, 12, 'default2', '%pink%'), (10, 16, 'default2', '%pink%'), (11, 12, 'default1', 'default2'), (12, 7, 'default1', NULL), (13, 12, '%pink%', '%Y'), (14, 14, 'default2', '%pink%'), (15, 4, 'default1', '%pink%'), (16, 9, 'default1', '%pink%');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 11, '%pink%', 'default2', '%pink%', 0.0, '%Y', 'default1'), (0, 10, '%Y', 'default2', '%Y', 1.0, 'default2', '%Y'), (1, 5, '%pink%', 'default1', '%Y', 2.0, '%Y', '%pink%'), (3, 15, 'default2', '%pink%', 'default2', 0.0, 'default2', '%Y'), (4, 10, '%Y', 'default2', 'default2', 0.0, 'default1', '%pink%'), (5, 16, 'default2', 'default2', 'default2', 0.0, '%Y', 'default1'), (6, 7, 'default1', '%pink%', 'default1', 2.0, 'default1', '%pink%'), (7, 15, 'default2', '%Y', '%Y', 1.0, '%pink%', '%Y'), (8, 2, 'default1', 'default2', 'default2', 1.0, 'default2', 'default1'), (9, 11, 'default1', '%pink%', 'default2', 2.0, '%pink%', '%pink%'), (10, 1, '%pink%', '%pink%', 'default1', 0.0, '%Y', 'default1'), (11, 8, '%Y', 'default1', 'default1', 2.0, 'default1', 'default2'), (12, 16, '%Y', 'default1', '%Y', 0.0, '%Y', 'default1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (0, 8, 'default1', 1.0, '2023-01-02', '%pink%', '%pink%', 0, '%pink%'), (2, 11, 'default1', 0.0, '2023-01-02', 'default2', '%Y', 0, 'default1'), (1, 9, '%Y', 1.0, '2023-01-02', '%Y', 'default2', 1, 'default2'), (3, 6, '%Y', 2.0, '2023-01-01', '%pink%', 'default1', 2, 'default2'), (4, 3, 'default1', 2.0, '2023-01-02', 'default1', '%pink%', 1, 'default2'), (5, 0, '%Y', 0.0, '2023-01-01', '%Y', '%Y', 1, '%Y'), (6, 6, '%Y', 0.0, '2023-01-01', 'default2', 'default2', 1, '%pink%'), (7, 7, 'default1', 1.0, '2023-01-02', '%Y', 'default1', 0, 'default1');
INSERT INTO supplier (s_suppkey, s_nationkey, s_name, s_address, s_phone, s_acctbal, s_comment) VALUES (1, 13, '%Y', '%Y', '%pink%', 0.0, '%pink%');
INSERT INTO lineitem (l_orderkey, l_linenumber, l_partkey, l_suppkey, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (0, 1, 2, 1, 0.0, 2.0, 2.0, 2.0, 'default1', 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', '%Y', '%pink%'), (1, 1, 2, 1, 0.0, 1.0, 2.0, 2.0, '%Y', '%Y', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default1', '%pink%'), (2, 0, 2, 1, 0.0, 0.0, 0.0, 0.0, 'default1', '%Y', '2023-01-01', '2023-01-01', '2023-01-02', 'default1', 'default2', 'default2'), (7, 2, 2, 1, 2.0, 1.0, 0.0, 2.0, 'default2', '%pink%', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', '%pink%', '%pink%');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 1, 0.0, '%pink%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, o_orderdate AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Gold Result:
('%pink%', '2023-01-02', -2.0)
*/

-- Prediction Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Prediction Result:
('%pink%', 2023, -2.0)
*/