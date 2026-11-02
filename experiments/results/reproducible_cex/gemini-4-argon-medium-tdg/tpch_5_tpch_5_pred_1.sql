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
-- DATASET 1
-- Tests:
-- 1. Boundary conditions on o_orderdate ('1993-12-31', '1994-01-01', '1994-12-31', '1995-01-01')
-- 2. SUM(l_extendedprice) vs COUNT / AVG / MIN / MAX / SUM(DISTINCT) / SUM(l_extendedprice * (1 - l_discount))
-- 3. Tie-breaking on ORDER BY (revenue DESC, n_name ASC) and multiple nations in 'AMERICA'
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'America region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'BRAZIL', 1, 'Nation 10');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (11, 'CANADA', 1, 'Nation 11');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (12, 'ARGENTINA', 1, 'Nation 12');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part 1', 'Mfgr#1', 'Brand#1', 'Type 1', 10, 'SM BOX', 100.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (100, 'Supp Brazil', 'Addr 1', 10, '111-111', 500.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (101, 'Supp Canada', 'Addr 2', 11, '222-222', 500.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (102, 'Supp Argentina', 'Addr 3', 12, '333-333', 500.00, 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (200, 'Cust Brazil', 'Addr 1', 10, '111-111', 500.00, 'AUTO', 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (201, 'Cust Canada', 'Addr 2', 11, '222-222', 500.00, 'AUTO', 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (202, 'Cust Argentina', 'Addr 3', 12, '333-333', 500.00, 'AUTO', 'Comment');
-- Valid orders on exact boundary dates
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1000, 200, 'O', 999.00, '1994-01-01', '1-URGENT', 'Clerk#1', 0, 'Valid lower bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1001, 201, 'O', 888.00, '1994-12-31', '1-URGENT', 'Clerk#1', 0, 'Valid upper bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1002, 202, 'O', 777.00, '1994-06-15', '1-URGENT', 'Clerk#1', 0, 'Valid mid year');
-- Invalid orders just outside boundaries
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1003, 200, 'O', 500.00, '1993-12-31', '1-URGENT', 'Clerk#1', 0, 'Too early');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1004, 200, 'O', 500.00, '1995-01-01', '1-URGENT', 'Clerk#1', 0, 'Too late');
-- Lineitems for BRAZIL (Total = 300.00, duplicate extendedprice 150.00 to test SUM vs SUM(DISTINCT), non-zero discount to test discount formula mutants)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1000, 1, 100, 1, 5.00, 150.00, 0.10, 0.05, 'N', 'O', '1994-01-02', '1994-01-02', '1994-01-03', 'NONE', 'TRUCK', 'Line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1000, 1, 100, 2, 10.00, 150.00, 0.20, 0.05, 'N', 'O', '1994-01-02', '1994-01-02', '1994-01-03', 'NONE', 'TRUCK', 'Line 2');
-- Lineitems for CANADA (Total = 300.00, ties with BRAZIL on revenue to test secondary sort on n_name)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1001, 1, 101, 1, 1.00, 300.00, 0.00, 0.00, 'N', 'O', '1994-12-31', '1994-12-31', '1994-12-31', 'NONE', 'TRUCK', 'Line 3');
-- Lineitems for ARGENTINA (Total = 500.00, highest revenue to test primary sort revenue DESC)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1002, 1, 102, 1, 2.00, 500.00, 0.05, 0.05, 'N', 'O', '1994-06-16', '1994-06-16', '1994-06-17', 'NONE', 'TRUCK', 'Line 4');
-- Lineitems for out-of-range orders (Should be excluded)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1003, 1, 100, 1, 1.00, 1000.00, 0.00, 0.00, 'N', 'O', '1994-01-05', '1994-01-05', '1994-01-06', 'NONE', 'TRUCK', 'Excluded early');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1004, 1, 100, 1, 1.00, 2000.00, 0.00, 0.00, 'N', 'O', '1995-01-02', '1995-01-02', '1995-01-03', 'NONE', 'TRUCK', 'Excluded late');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_name, SUM(l_extendedprice) AS revenue FROM orders CROSS JOIN supplier CROSS JOIN region CROSS JOIN customer CROSS JOIN nation CROSS JOIN lineitem WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND o_orderdate >= '1994-01-01' AND o_orderdate < '1995-01-01' GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Gold Result:
('ARGENTINA', 500.0)
('BRAZIL', 300.0)
('CANADA', 300.0)
*/

-- Prediction Query
SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND o_orderdate >= DATE('1994-01-01') AND o_orderdate > DATE('1994-01-01', '+1 year') GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Prediction Result:
*/