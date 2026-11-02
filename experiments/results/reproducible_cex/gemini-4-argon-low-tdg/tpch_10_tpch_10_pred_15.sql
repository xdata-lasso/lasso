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
-- Tests exact date boundaries ('1993-03-01', '1993-03-02', '1993-05-31', '1993-06-01'),
-- returnflag conditions ('R', 'A', 'N', 'r'), and inner join filtering vs left joins.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'Nation 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (2, 'CANADA', 1, 'Unused Nation');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp1', 'Addr1', 1, '111-1111', 100.00, 'Supp comment');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part1', 'Mfgr1', 'Brand1', 'Type1', 10, 'BOX', 50.00, 'Part comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust_LowerBound_Excl', '101 Main', 1, '555-0101', 500.00, 'AUTO', 'Excluded lower bound date');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust_LowerBound_Incl', '102 Main', 1, '555-0102', 600.00, 'AUTO', 'Included just inside lower bound');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust_UpperBound_Incl', '103 Main', 1, '555-0103', 700.00, 'AUTO', 'Included just inside upper bound');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Cust_UpperBound_Excl', '104 Main', 1, '555-0104', 800.00, 'AUTO', 'Excluded upper bound date');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Cust_Wrong_Flags', '105 Main', 1, '555-0105', 900.00, 'AUTO', 'Valid date but non-R flags');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (6, 'Cust_No_Orders', '106 Main', 1, '555-0106', 950.00, 'AUTO', 'Customer with no orders at all');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 1, 'F', 1000.00, '1993-03-01', '1-URGENT', 'Clerk1', 0, 'Exact lower bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 2, 'F', 2000.00, '1993-03-02', '1-URGENT', 'Clerk1', 0, 'Inside lower bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 3, 'F', 3000.00, '1993-05-31', '1-URGENT', 'Clerk1', 0, 'Inside upper bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 4, 'F', 4000.00, '1993-06-01', '1-URGENT', 'Clerk1', 0, 'Exact upper bound');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (105, 5, 'F', 5000.00, '1993-04-15', '1-URGENT', 'Clerk1', 0, 'Middle of date range');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 1, 1.0, 1000.00, 0.05, 0.02, 'R', 'F', '1993-03-05', '1993-03-05', '1993-03-10', 'NONE', 'AIR', 'Boundary test 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 1, 2.0, 2000.00, 0.10, 0.02, 'R', 'F', '1993-03-05', '1993-03-05', '1993-03-10', 'NONE', 'AIR', 'Boundary test 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 1, 3.0, 3000.00, 0.00, 0.02, 'R', 'F', '1993-06-01', '1993-06-01', '1993-06-05', 'NONE', 'AIR', 'Boundary test 3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 1, 4.0, 4000.00, 0.05, 0.02, 'R', 'F', '1993-06-05', '1993-06-05', '1993-06-10', 'NONE', 'AIR', 'Boundary test 4');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 1, 5.0, 5000.00, 0.05, 0.02, 'A', 'F', '1993-04-20', '1993-04-20', '1993-04-25', 'NONE', 'AIR', 'Flag A');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 2, 5.0, 5000.00, 0.05, 0.02, 'N', 'O', '1993-04-20', '1993-04-20', '1993-04-25', 'NONE', 'AIR', 'Flag N');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 3, 5.0, 5000.00, 0.05, 0.02, 'r', 'F', '1993-04-20', '1993-04-20', '1993-04-25', 'NONE', 'AIR', 'Lowercase r flag');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_custkey, c_name, SUM(l_extendedprice) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN nation WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate > '1993-03-01' AND o_orderdate < '1993-06-01' AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Gold Result:
(3, 'Cust_UpperBound_Incl', 3000.0, 700.0, 'USA', '103 Main', '555-0103', 'Included just inside upper bound')
(2, 'Cust_LowerBound_Incl', 2000.0, 600.0, 'USA', '102 Main', '555-0102', 'Included just inside lower bound')
*/

-- Prediction Query
SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM (SELECT * FROM customer CROSS JOIN nation WHERE c_nationkey = n_nationkey) AS l LEFT OUTER JOIN (SELECT * FROM orders CROSS JOIN lineitem WHERE l_orderkey = o_orderkey AND o_orderdate >= DATE('1993-03-01') AND o_orderdate < DATE('1993-03-01', '+3 month') AND l_returnflag = 'R') AS r ON (c_custkey = o_custkey) GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Prediction Result:
(4, 'Cust_UpperBound_Excl', None, 800.0, 'USA', '104 Main', '555-0104', 'Excluded upper bound date')
(5, 'Cust_Wrong_Flags', None, 900.0, 'USA', '105 Main', '555-0105', 'Valid date but non-R flags')
(6, 'Cust_No_Orders', None, 950.0, 'USA', '106 Main', '555-0106', 'Customer with no orders at all')
(3, 'Cust_UpperBound_Incl', 3000.0, 700.0, 'USA', '103 Main', '555-0103', 'Included just inside upper bound')
(2, 'Cust_LowerBound_Incl', 1800.0, 600.0, 'USA', '102 Main', '555-0102', 'Included just inside lower bound')
(1, 'Cust_LowerBound_Excl', 950.0, 500.0, 'USA', '101 Main', '555-0101', 'Excluded lower bound date')
*/