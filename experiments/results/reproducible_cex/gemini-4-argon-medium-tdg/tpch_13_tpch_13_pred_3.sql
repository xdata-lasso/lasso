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
-- Tests core LEFT JOIN, COUNT(o_orderkey) vs COUNT(*), ON vs WHERE filtering, and primary/secondary ORDER BY directions.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'Nation 1');
-- Customer 1: No orders at all (c_count = 0)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust 1', 'Addr 1', 1, '111-1111', 100.00, 'AUTO', 'No orders');
-- Customer 2: Only excluded orders matching '%pending%accounts%' (c_count = 0)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust 2', 'Addr 2', 1, '222-2222', 200.00, 'AUTO', 'Only excluded orders');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 2, 'O', 50.00, '2023-01-01', '1-URGENT', 'Clerk#1', 0, 'the pending accounts are delayed');
-- Customer 3: 1 valid order, 1 excluded order (c_count = 1)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust 3', 'Addr 3', 1, '333-3333', 300.00, 'AUTO', 'Mixed orders');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 3, 'O', 150.00, '2023-01-02', '1-URGENT', 'Clerk#1', 0, 'normal order comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 3, 'O', 250.00, '2023-01-03', '1-URGENT', 'Clerk#1', 0, 'pendingaccounts');
-- Customer 4: 1 valid order (c_count = 1)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Cust 4', 'Addr 4', 1, '444-4444', 400.00, 'AUTO', 'One valid order');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 4, 'F', 350.00, '2023-01-04', '2-HIGH', 'Clerk#2', 0, 'accounts that are pending now');
-- Customer 5: 1 valid order (c_count = 1) -> Makes custdist = 3 for c_count = 1
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Cust 5', 'Addr 5', 1, '555-5555', 500.00, 'AUTO', 'One valid order');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (105, 5, 'F', 450.00, '2023-01-05', '2-HIGH', 'Clerk#2', 0, 'just pending');
-- Customer 6: 2 valid orders (c_count = 2) -> custdist = 1
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (6, 'Cust 6', 'Addr 6', 1, '666-6666', 600.00, 'AUTO', 'Two valid orders');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (106, 6, 'O', 550.00, '2023-01-06', '3-MEDIUM', 'Clerk#3', 0, 'just accounts');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (107, 6, 'O', 650.00, '2023-01-07', '3-MEDIUM', 'Clerk#3', 0, 'clean comment');
-- Customer 7: 3 valid orders (c_count = 3) -> custdist = 1 (Ties with c_count = 2 on custdist, tests secondary sort c_count DESC)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (7, 'Cust 7', 'Addr 7', 1, '777-7777', 700.00, 'AUTO', 'Three valid orders');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (108, 7, 'O', 750.00, '2023-01-08', '3-MEDIUM', 'Clerk#3', 0, 'valid 1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (109, 7, 'O', 850.00, '2023-01-09', '3-MEDIUM', 'Clerk#3', 0, 'valid 2');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (110, 7, 'O', 950.00, '2023-01-10', '3-MEDIUM', 'Clerk#3', 0, 'valid 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_count, COUNT(c_custkey) AS custdist FROM (SELECT c_custkey AS c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%pending%accounts%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST;

/*
Gold Result:
(1, 3)
(0, 2)
(3, 1)
(2, 1)
*/

-- Prediction Query
SELECT c_count, COUNT(*) AS custdist FROM (SELECT c_custkey AS c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%pending_accounts%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST;

/*
Prediction Result:
(2, 2)
(1, 2)
(0, 2)
(3, 1)
*/