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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'UNITED STATES', 1, 'nation 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (2, 'CANADA', 1, 'nation 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (101, 'Cust 101', 'Addr 101', 1, '11-100-1000', 100.00, 'AUTOMOBILE', 'subquery match 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (102, 'Cust 102', 'Addr 102', 2, '11-100-1000', 100.00, 'BUILDING', 'subquery match 2 duplicate bal with order');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (103, 'Cust 103', 'Addr 103', 1, '11-200-2000', 400.00, 'MACHINERY', 'subquery match 3');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (104, 'Cust 104', 'Addr 104', 1, '11-300-3000', 0.00, 'AUTOMOBILE', 'subquery zero balance boundary');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (105, 'Cust 105', 'Addr 105', 1, '11-400-4000', -300.00, 'AUTOMOBILE', 'subquery negative balance');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust 1', 'Addr 1', 1, '10-000-0001', -50.00, 'AUTOMOBILE', 'negative bal');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust 2', 'Addr 2', 1, '10-000-0002', 50.00, 'AUTOMOBILE', 'below unguarded avg 60');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust 3', 'Addr 3', 1, '10-000-0003', 80.00, 'AUTOMOBILE', 'between 60 and min 100');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Cust 4', 'Addr 4', 1, '10-000-0004', 120.00, 'AUTOMOBILE', 'between 100 and zero-included avg 150');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Cust 5', 'Addr 5', 1, '10-000-0005', 180.00, 'AUTOMOBILE', 'between 150 and true avg 200');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (6, 'Cust 6', 'Addr 6', 1, '10-000-0006', 200.00, 'AUTOMOBILE', 'exact boundary equal to true avg 200');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (7, 'Cust 7', 'Addr 7', 1, '10-111-1111', 900.00, 'AUTOMOBILE', 'qualifying phone and bal but has orders');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (8, 'Cust 8', 'Addr 8', 1, '10-999-9999', 800.00, 'AUTOMOBILE', 'qualifying phone and bal but has order');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (11, 'Cust 11', 'Addr 11', 1, '10-111-1111', 220.00, 'AUTOMOBILE', 'group 1 cust 1 between 200 and 250');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (12, 'Cust 12', 'Addr 12', 2, '10-111-1111', 220.00, 'BUILDING', 'group 1 cust 2 duplicate bal');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (13, 'Cust 13', 'Addr 13', 1, '10-111-1111', 450.00, 'MACHINERY', 'group 1 cust 3');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (14, 'Cust 14', 'Addr 14', 1, '10-222-2222', 1500.00, 'AUTOMOBILE', 'group 2 single cust highest totacctbal');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (15, 'Cust 15', 'Addr 15', 1, '10-333-3333', 300.00, 'AUTOMOBILE', 'group 3 cust 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (16, 'Cust 16', 'Addr 16', 2, '10-333-3333', 350.00, 'BUILDING', 'group 3 cust 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (20, 'Cust 20', 'Addr 20', 1, '210-111-1111', 900.00, 'AUTOMOBILE', 'non-prefix 10');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (21, 'Cust 21', 'Addr 21', 1, '211-111-1111', 5000.00, 'AUTOMOBILE', 'non-prefix 11');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (22, 'Cust 22', 'Addr 22', 1, '12-111-1111', 900.00, 'AUTOMOBILE', 'other prefix 12');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1001, 7, 'O', 100.00, '1995-01-01', '1-URGENT', 'Clerk#1', 0, 'order 1 for cust 7');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1002, 7, 'O', 200.00, '1995-01-02', '1-URGENT', 'Clerk#1', 0, 'order 2 for cust 7');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1003, 8, 'F', 150.00, '1995-01-03', '2-HIGH', 'Clerk#2', 0, 'order 1 for cust 8');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1004, 102, 'F', 300.00, '1995-01-04', '3-MEDIUM', 'Clerk#3', 0, 'order for 11% cust 102');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_phone AS cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM customer WHERE (c_phone LIKE '10%') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND c_phone LIKE '11%') AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey) GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Gold Result:
('10-111-1111', 3, 890.0)
('10-222-2222', 1, 1500.0)
('10-333-3333', 2, 650.0)
*/

-- Prediction Query
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM (SELECT SUBSTRING(c_phone, 1, 2) AS cntrycode, c_acctbal FROM customer WHERE SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27') AND c_acctbal = (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27')) AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey)) AS custsale GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Prediction Result:
*/