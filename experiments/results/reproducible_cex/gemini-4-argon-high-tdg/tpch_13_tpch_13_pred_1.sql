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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'region comment');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'UNITED STATES', 1, 'nation comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Customer#Same', '100 Main St', 1, '111-111-1111', 100.00, 'BUILDING', 'same attrs');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Customer#Same', '100 Main St', 1, '111-111-1111', 100.00, 'BUILDING', 'same attrs');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Customer#0003', '103 Main St', 1, '111-111-1113', 300.00, 'AUTOMOBILE', 'comment 3');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Customer#0004', '104 Main St', 1, '111-111-1114', 400.00, 'MACHINERY', 'comment 4');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Customer#0005', '105 Main St', 1, '111-111-1115', 500.00, 'HOUSEHOLD', 'comment 5');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (6, 'Customer#0006', '106 Main St', 1, '111-111-1116', 600.00, 'FURNITURE', 'comment 6');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (7, 'Customer#0007', '107 Main St', 1, '111-111-1117', 700.00, 'BUILDING', 'comment 7');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (8, 'Customer#0008', '108 Main St', 1, '111-111-1118', 800.00, 'AUTOMOBILE', 'comment 8');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 2, 'O', 150.00, '1995-01-10', '1-URGENT', 'Clerk#001', 0, 'aa pending bb accounts cc');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 2, 'O', 250.00, '1995-01-11', '1-URGENT', 'Clerk#001', 0, 'pendingaccounts');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 3, 'F', 300.00, '1995-02-01', '2-HIGH', 'Clerk#002', 0, 'normal order comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 3, 'F', 350.00, '1995-02-02', '2-HIGH', 'Clerk#002', 0, 'my pending accounts here');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (105, 4, 'O', 400.00, '1995-03-01', '3-MEDIUM', 'Clerk#003', 0, 'only pending here');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (106, 5, 'O', 500.00, '1995-03-05', '3-MEDIUM', 'Clerk#003', 0, 'only accounts here');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (107, 6, 'F', 600.00, '1995-04-01', '4-NOT SPECIFIED', 'Clerk#004', 0, 'accounts before pending');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (108, 6, 'F', 650.00, '1995-04-02', '4-NOT SPECIFIED', 'Clerk#004', 0, 'regular comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (109, 7, 'O', 700.00, '1995-05-01', '5-LOW', 'Clerk#005', 0, 'dup valid comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (110, 7, 'O', 700.00, '1995-05-01', '5-LOW', 'Clerk#005', 0, 'dup valid comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (111, 7, 'O', 700.00, '1995-05-01', '5-LOW', 'Clerk#005', 0, 'pending   accounts');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (112, 8, 'F', 800.00, '1995-06-01', '1-URGENT', 'Clerk#006', 0, 'identical order');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (113, 8, 'F', 800.00, '1995-06-01', '1-URGENT', 'Clerk#006', 0, 'identical order');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (114, 8, 'F', 800.00, '1995-06-01', '1-URGENT', 'Clerk#006', 0, 'identical order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_count, COUNT(c_custkey) AS custdist FROM (SELECT c_custkey AS c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%pending%accounts%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST;

/*
Gold Result:
(1, 3)
(2, 2)
(0, 2)
(3, 1)
*/

-- Prediction Query
SELECT c_count, COUNT(*) AS custdist FROM (SELECT c_custkey AS c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment LIKE '%pending%accounts%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST;

/*
Prediction Result:
(0, 5)
(1, 2)
(2, 1)
*/