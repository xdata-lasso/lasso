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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (0, '11%', 'default1'), (2, '10%', '10');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (2, 2, 'default2', '11%'), (0, 2, '20', '11%'), (3, 0, 'default1', '11'), (1, 2, 'default2', '26'), (4, 2, '27', '20'), (5, 2, '10%', 'default1'), (6, 2, '11%', '20'), (7, 0, '11%', '20'), (8, 0, '22', '19'), (9, 0, '10', '11');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (0, 8, '27', '10', '11%', 1.0, 'default1', 'default2'), (2, 8, '11', '10%', 'default2', 2.0, '10', '19'), (3, 4, 'default1', '26', '11%', 3.0, '10', '10'), (1, 3, 'default2', '20', '22', -1.0, '22', '27'), (4, 7, 'default1', '27', '27', 0.0, 'default2', '27'), (5, 7, '10%', '22', '11', -1.0, '11%', '10'), (6, 8, 'default1', '10', '10%', -1.0, '20', '10'), (7, 5, '11%', '11%', 'default1', 3.0, '26', '19'), (8, 0, '26', '11%', 'default2', 0.0, '27', 'default1'), (9, 2, 'default1', '27', '11', 1.0, '26', 'default2'), (10, 2, '19', '11%', '11', 0.0, '22', '11%'), (11, 5, '27', '10', '27', 0.0, 'default1', '26'), (12, 9, '22', '11%', '11', 3.0, 'default2', '11%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_phone AS cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM customer WHERE (c_phone LIKE '10%') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND c_phone LIKE '11%') AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey) GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM (SELECT SUBSTRING(c_phone, 1, 2) AS cntrycode, c_acctbal FROM customer WHERE SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal >= 0.00 AND SUBSTRING(c_phone, 1, 2) IN ('10', '11', '26', '22', '19', '20', '27')) AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey)) AS custsale GROUP BY cntrycode ORDER BY cntrycode NULLS LAST, numcust NULLS LAST, totacctbal NULLS LAST;

/*
Prediction Result:
('11', 2, 6.0)
*/