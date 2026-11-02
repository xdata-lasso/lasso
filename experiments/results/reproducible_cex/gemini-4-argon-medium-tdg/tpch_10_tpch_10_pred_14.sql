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
-- Focus: Strict boundary conditions on o_orderdate ('1993-03-01', '1993-03-02', '1993-05-31', '1993-06-01') and l_returnflag ('R' vs 'A', 'N')
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'UNITED STATES', 1, 'Nation 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supplier#1', 'Addr 1', 1, '111-111', 100.00, 'Supp 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part 1', 'Mfgr 1', 'Brand 1', 'Type 1', 10, 'SM BOX', 50.00, 'Part 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust 1', 'CAddr 1', 1, '222-111', 500.00, 'BUILDING', 'Comment 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust 2', 'CAddr 2', 1, '222-222', 600.00, 'BUILDING', 'Comment 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust 3', 'CAddr 3', 1, '222-333', 700.00, 'BUILDING', 'Comment 3');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Cust 4', 'CAddr 4', 1, '222-444', 800.00, 'BUILDING', 'Comment 4');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Cust 5', 'CAddr 5', 1, '222-555', 900.00, 'BUILDING', 'Comment 5');
-- Order on exact lower bound (should be excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 1, 'F', 1000.00, '1993-03-01', '1-URGENT', 'Clerk#1', 0, 'Exact lower bound');
-- Order just inside lower bound (should be included)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 2, 'F', 2000.00, '1993-03-02', '1-URGENT', 'Clerk#1', 0, 'Inside lower bound');
-- Order just inside upper bound (should be included)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 3, 'F', 3000.00, '1993-05-31', '1-URGENT', 'Clerk#1', 0, 'Inside upper bound');
-- Order on exact upper bound (should be excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 4, 'F', 4000.00, '1993-06-01', '1-URGENT', 'Clerk#1', 0, 'Exact upper bound');
-- Order well inside date range, testing returnflag variations
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (105, 5, 'F', 5000.00, '1993-04-15', '1-URGENT', 'Clerk#1', 0, 'Mid range');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 1, 10.0, 111.11, 0.05, 0.02, 'R', 'F', '1993-03-05', '1993-03-05', '1993-03-10', 'NONE', 'TRUCK', 'Excluded by date');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 1, 10.0, 222.22, 0.05, 0.02, 'R', 'F', '1993-03-05', '1993-03-05', '1993-03-10', 'NONE', 'TRUCK', 'Included');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 1, 10.0, 333.33, 0.05, 0.02, 'R', 'F', '1993-06-05', '1993-06-05', '1993-06-10', 'NONE', 'TRUCK', 'Included');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 1, 10.0, 444.44, 0.05, 0.02, 'R', 'F', '1993-06-05', '1993-06-05', '1993-06-10', 'NONE', 'TRUCK', 'Excluded by date');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 1, 10.0, 555.55, 0.05, 0.02, 'A', 'F', '1993-04-20', '1993-04-20', '1993-04-25', 'NONE', 'TRUCK', 'Excluded by returnflag A');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 2, 10.0, 666.66, 0.05, 0.02, 'N', 'O', '1993-04-20', '1993-04-20', '1993-04-25', 'NONE', 'TRUCK', 'Excluded by returnflag N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_custkey, c_name, SUM(l_extendedprice) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN nation WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate > '1993-03-01' AND o_orderdate < '1993-06-01' AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Gold Result:
(3, 'Cust 3', 333.33, 700.0, 'UNITED STATES', 'CAddr 3', '222-333', 'Comment 3')
(2, 'Cust 2', 222.22, 600.0, 'UNITED STATES', 'CAddr 2', '222-222', 'Comment 2')
*/

-- Prediction Query
SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN nation WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey OR o_orderdate >= DATE('1993-03-01') AND o_orderdate < DATE('1993-03-01', '+3 month') AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Prediction Result:
(5, 'Cust 5', 5383.2795, 900.0, 'UNITED STATES', 'CAddr 5', '222-555', 'Comment 5')
(4, 'Cust 4', 4644.397999999999, 800.0, 'UNITED STATES', 'CAddr 4', '222-444', 'Comment 4')
(1, 'Cust 1', 4222.179999999999, 500.0, 'UNITED STATES', 'CAddr 1', '222-111', 'Comment 1')
(2, 'Cust 2', 4222.179999999999, 600.0, 'UNITED STATES', 'CAddr 2', '222-222', 'Comment 2')
(3, 'Cust 3', 4222.179999999999, 700.0, 'UNITED STATES', 'CAddr 3', '222-333', 'Comment 3')
*/