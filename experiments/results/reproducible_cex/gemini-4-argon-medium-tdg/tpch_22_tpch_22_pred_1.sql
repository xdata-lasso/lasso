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
-- Comprehensive dataset testing boundary conditions on AVG(c_acctbal), LIKE '10%' vs '11%', NOT EXISTS(orders), and GROUP BY / ORDER BY with duplicates and ties.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'Nation 1');
-- Subquery customers (c_phone LIKE '11%'):
-- Cust 1 & 2 have c_acctbal > 0.00 -> AVG is (100.00 + 200.00) / 2 = 150.00
-- Cust 3 has c_acctbal = 0.00 (boundary test for > 0.00 vs >= 0.00)
-- Cust 4 has c_acctbal = -50.00 (test for negative balance exclusion)
-- Cust 5 has c_phone = '211-000' (test for '11%' vs '%11%')
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Sub1', 'Addr1', 1, '11-111-1111', 100.00, 'AUTO', 'Valid sub 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Sub2', 'Addr2', 1, '11-222-2222', 200.00, 'AUTO', 'Valid sub 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'SubZero', 'Addr3', 1, '11-333-3333', 0.00, 'AUTO', 'Zero balance');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (4, 'SubNeg', 'Addr4', 1, '11-444-4444', -50.00, 'AUTO', 'Negative balance');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (5, 'SubWrongPhone', 'Addr5', 1, '211-555-5555', 500.00, 'AUTO', 'Not starting with 11');
-- Outer query customers (c_phone LIKE '10%'):
-- Cust 10: c_acctbal = 150.00 (boundary test for > AVG vs >= AVG, should be excluded)
-- Cust 11: c_acctbal = 150.01 (just above AVG, no orders -> INCLUDED)
-- Cust 12: c_acctbal = 200.00 (above AVG, shares phone '10-111-1111' with Cust 11 to test GROUP BY, COUNT, SUM -> INCLUDED)
-- Cust 13: c_acctbal = 300.00 (above AVG, different phone '10-222-2222', no orders -> INCLUDED)
-- Cust 14: c_acctbal = 400.00 (above AVG, has an order -> EXCLUDED by NOT EXISTS)
-- Cust 15: c_acctbal = 500.00 (phone '210-111-1111' -> EXCLUDED by LIKE '10%')
-- Cust 16: c_acctbal = 200.00 (phone '10-050-0000' -> INCLUDED, tests ORDER BY cntrycode)
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (10, 'OuterEqAvg', 'Addr10', 1, '10-000-0000', 150.00, 'AUTO', 'Equal to AVG');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (11, 'OuterValid1', 'Addr11', 1, '10-111-1111', 150.01, 'AUTO', 'Group 1A');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (12, 'OuterValid2', 'Addr12', 1, '10-111-1111', 200.00, 'AUTO', 'Group 1B');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (13, 'OuterValid3', 'Addr13', 1, '10-222-2222', 300.00, 'AUTO', 'Group 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (14, 'OuterWithOrder', 'Addr14', 1, '10-111-1111', 400.00, 'AUTO', 'Has order');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (15, 'OuterWrongPhone', 'Addr15', 1, '210-111-1111', 500.00, 'AUTO', 'Wrong phone prefix');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (16, 'OuterValid4', 'Addr16', 1, '10-050-0000', 200.00, 'AUTO', 'Group 0');
-- Orders to test NOT EXISTS (and ensure subquery customers with orders are still included in AVG):
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (100, 14, 'O', 1000.00, '2023-01-01', '1-URGENT', 'Clerk1', 0, 'Excludes cust 14');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 1, 'O', 500.00, '2023-01-02', '1-URGENT', 'Clerk1', 0, 'Subquery cust 1 has order, still in AVG');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_phone AS cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM customer WHERE (c_phone LIKE '10%') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND c_phone LIKE '11%') AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey) GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Gold Result:
('10-050-0000', 1, 200.0)
('10-111-1111', 2, 350.01)
('10-222-2222', 1, 300.0)
*/

-- Prediction Query
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM (SELECT SUBSTRING(c_phone, 1, 2) AS cntrycode, c_acctbal FROM customer WHERE SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal >= 0.00 AND SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27')) AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey)) AS custsale GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Prediction Result:
('10', 3, 700.0)
('11', 1, 200.0)
*/