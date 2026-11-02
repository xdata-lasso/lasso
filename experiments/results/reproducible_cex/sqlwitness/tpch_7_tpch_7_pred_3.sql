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
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'default1', 'FRANCE', '1995-01-01', '1995-01-02', 1, 'default2', 0.0, 'default1'), (2, 'default2', '1996-12-31', '1996-12-31', '1995-01-01', 0, 'default1', 1.0, 'ARGENTINA'), (0, 'FRANCE', '%Y', 'FRANCE', '1996-12-31', 2, '1996-12-31', 2.0, '%Y'), (3, 'FRANCE', '%Y', 'FRANCE', 'default2', 2, 'default1', 2.0, '1995-01-01'), (4, 'ARGENTINA', 'ARGENTINA', '1995-01-01', '%Y', 2, 'FRANCE', 1.0, 'default1'), (5, 'default2', '%Y', 'default1', 'default1', 0, 'default2', 2.0, '1995-01-01');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (0, 'default1', '1995-01-02'), (1, 'default2', NULL), (2, '1995-01-02', 'FRANCE'), (3, '1995-01-01', 'FRANCE'), (4, '1995-01-01', 'default1'), (5, 'FRANCE', 'FRANCE'), (6, 'default1', 'default2');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (0, 6, 'FRANCE', '1996-12-31');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (0, 0, 'default1', '1995-01-02', 'FRANCE', 2.0, 'default2', '1995-01-02');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (2, 0, 'default2', 1.0, '2023-01-01', '%Y', '1995-01-02', 2, '1996-12-31'), (0, 0, '1995-01-01', 2.0, '1997-01-01', 'default1', 'default1', 0, '1995-01-01'), (1, 0, 'default2', 1.0, '1996-12-31', 'default2', 'ARGENTINA', 1, 'default1'), (3, 0, '1995-01-01', 0.0, '2023-01-01', 'ARGENTINA', '1995-01-02', 0, '1995-01-02'), (4, 0, '%Y', 1.0, '1996-12-31', '1996-12-31', 'default1', 1, 'default1'), (5, 0, 'FRANCE', 1.0, '1994-12-31', '1995-01-01', 'default1', 2, '1995-01-01'), (6, 0, '1995-01-02', 1.0, '2023-01-01', '1996-12-31', 'default1', 0, '%Y');
INSERT INTO supplier (s_suppkey, s_nationkey, s_name, s_address, s_phone, s_acctbal, s_comment) VALUES (2, 0, '%Y', '1996-12-31', '1995-01-02', 1.0, 'FRANCE'), (1, 0, 'FRANCE', '1995-01-01', 'ARGENTINA', 1.0, '%Y'), (0, 0, 'default2', 'ARGENTINA', 'FRANCE', 0.0, 'FRANCE'), (3, 0, '%Y', '1995-01-02', '%Y', 0.0, 'ARGENTINA');
INSERT INTO lineitem (l_orderkey, l_linenumber, l_partkey, l_suppkey, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5, 1, 2, 2, 2.0, 1.0, 2.0, 2.0, '1995-01-01', 'default1', '1996-12-31', '1995-01-02', '1996-12-30', '1996-12-31', '%Y', 'ARGENTINA'), (1, 1, 4, 2, 2.0, 1.0, 1.0, 0.0, '%Y', '1995-01-01', '1995-01-01', '1995-01-03', '1995-01-03', 'ARGENTINA', 'FRANCE', 'default2'), (6, 1, 4, 3, 2.0, 0.0, 0.0, 0.0, 'default1', '1995-01-01', '1995-01-01', '1996-12-31', '2023-01-02', '1995-01-01', 'default1', 'FRANCE'), (2, 2, 1, 0, 2.0, 2.0, 1.0, 1.0, 'FRANCE', '1996-12-31', '1995-01-02', '1994-12-31', '1994-12-31', '%Y', '1995-01-01', '1995-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, l_shipdate AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA')) AND l_shipdate > '1995-01-02' AND l_shipdate < '1996-12-31') AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, CAST(STRFTIME('%Y', l_shipdate) AS INTEGER) AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name <> 'ARGENTINA') OR (n1.n_name = 'ARGENTINA' AND n2.n_name = 'FRANCE')) AND l_shipdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31')) AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Prediction Result:
('FRANCE', 'FRANCE', 1995, 0.0)
('FRANCE', 'FRANCE', 1996, -1.0)
*/