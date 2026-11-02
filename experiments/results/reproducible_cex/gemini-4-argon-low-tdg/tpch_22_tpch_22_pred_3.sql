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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'comment');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'comment');
-- Subquery customers (c_phone LIKE '11%' AND c_acctbal > 0.00 -> AVG = (100 + 200)/2 = 150.00)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust1', 'Addr1', 1, '11-111', 100.00, 'AUTO', 'Valid avg contributor 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust2', 'Addr2', 1, '11-222', 200.00, 'AUTO', 'Valid avg contributor 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust3', 'Addr3', 1, '11-333', 0.00, 'AUTO', 'Boundary: acctbal = 0.00, excluded from avg');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'Cust4', 'Addr4', 1, '11-444', -300.00, 'AUTO', 'Boundary: acctbal < 0.00, excluded from avg');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'Cust5', 'Addr5', 1, '99-111', 5000.00, 'AUTO', 'Contains 11 but does not start with 11');
-- Outer query candidates (c_phone LIKE '10%', compared against AVG = 150.00)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (6, 'Cust6', 'Addr6', 1, '10-100', 150.00, 'AUTO', 'Boundary: acctbal == AVG (150.00), should be excluded');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (7, 'Cust7', 'Addr7', 1, '10-100', 140.00, 'AUTO', 'Boundary: acctbal < AVG, should be excluded');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (8, 'Cust8', 'Addr8', 1, '10-200', 250.00, 'AUTO', 'Has orders, should be excluded by NOT EXISTS');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (9, 'Cust9', 'Addr9', 1, '99-100', 300.00, 'AUTO', 'Contains 10 but does not start with 10');
-- Valid outer query matches (Group 1: '10-300', 2 customers, duplicate acctbal to test SUM(DISTINCT) and COUNT)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (10, 'Cust10', 'Addr10', 1, '10-300', 200.00, 'AUTO', 'Valid match 1 in group 10-300');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (11, 'Cust11', 'Addr11', 1, '10-300', 200.00, 'AUTO', 'Valid match 2 in group 10-300');
-- Valid outer query matches (Group 2: '10-400', 1 customer, tests GROUP BY and ORDER BY)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (12, 'Cust12', 'Addr12', 1, '10-400', 500.00, 'AUTO', 'Valid match 1 in group 10-400');
-- Orders to test NOT EXISTS correlation
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 8, 'O', 1000.00, '2023-01-01', '1-URGENT', 'Clerk1', 0, 'Order for Cust8');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 1, 'O', 500.00, '2023-01-02', '1-URGENT', 'Clerk1', 0, 'Order for Subquery Cust1 (should still be in AVG)');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_phone AS cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM customer WHERE (c_phone LIKE '10%') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND c_phone LIKE '11%') AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey) GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Gold Result:
('10-300', 2, 400.0)
('10-400', 1, 500.0)
*/

-- Prediction Query
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM (SELECT SUBSTRING(c_phone, 1, 2) AS cntrycode, c_acctbal FROM customer WHERE SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27') AND c_acctbal < (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27')) AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey)) AS custsale GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Prediction Result:
('10', 4, 690.0)
('11', 3, -100.0)
*/