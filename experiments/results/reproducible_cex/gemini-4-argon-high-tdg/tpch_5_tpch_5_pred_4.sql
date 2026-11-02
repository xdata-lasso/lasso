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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Western Hemisphere');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'BRAZIL', 1, 'South America');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (20, 'CANADA', 1, 'North America');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (30, 'UNITED STATES', 1, 'North America');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2001, 'Part A', 'Mfgr#1', 'Brand#11', 'STANDARD', 10, 'SM BOX', 100.00, 'part comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (101, 'Supp#1', '100 Main', 10, '20-111-1111', 500.00, 'supp 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (102, 'Supp#2', '200 Main', 20, '30-222-2222', 600.00, 'supp 2');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (103, 'Supp#3', '300 Main', 30, '40-333-3333', 700.00, 'supp 3');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1001, 'Cust#1', '10 Elm', 10, '20-999-1111', 1000.00, 'AUTOMOBILE', 'cust 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1002, 'Cust#2', '20 Elm', 20, '30-999-2222', 1200.00, 'BUILDING', 'cust 2');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1003, 'Cust#3', '30 Elm', 30, '40-999-3333', 1500.00, 'MACHINERY', 'cust 3');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (5001, 1001, 'F', 999.00, '1994-03-15', '1-URGENT', 'Clerk#1', 0, 'order 1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (5002, 1002, 'O', 888.00, '1994-06-20', '2-HIGH', 'Clerk#2', 0, 'order 2');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (5003, 1003, 'F', 777.00, '1994-09-10', '3-MEDIUM', 'Clerk#3', 0, 'order 3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5001, 2001, 101, 1, 5.00, 150.00, 0.10, 0.05, 'R', 'F', '1994-04-01', '1994-04-01', '1994-04-05', 'DELIVER IN PERSON', 'TRUCK', 'brazil line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5002, 2001, 102, 1, 10.00, 250.00, 0.20, 0.08, 'A', 'F', '1994-07-01', '1994-07-01', '1994-07-05', 'NONE', 'AIR', 'canada duplicate price 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5002, 2001, 102, 2, 10.00, 250.00, 0.00, 0.02, 'N', 'O', '1994-07-02', '1994-07-02', '1994-07-06', 'NONE', 'MAIL', 'canada duplicate price 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5003, 2001, 103, 1, 8.00, 400.00, 0.05, 0.06, 'R', 'F', '1994-10-01', '1994-10-01', '1994-10-05', 'TAKE BACK RETURN', 'RAIL', 'us line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5003, 2001, 103, 2, 12.00, 600.00, 0.15, 0.04, 'A', 'F', '1994-10-02', '1994-10-02', '1994-10-06', 'COLLECT COD', 'SHIP', 'us line 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_name, SUM(l_extendedprice) AS revenue FROM orders CROSS JOIN supplier CROSS JOIN region CROSS JOIN customer CROSS JOIN nation CROSS JOIN lineitem WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND o_orderdate >= '1994-01-01' AND o_orderdate < '1995-01-01' GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Gold Result:
('UNITED STATES', 1000.0)
('CANADA', 500.0)
('BRAZIL', 150.0)
*/

-- Prediction Query
SELECT n_name, SUM(DISTINCT l_extendedprice * (1 - l_discount)) AS revenue FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND o_orderdate >= DATE('1994-01-01') AND o_orderdate < DATE('1994-01-01', '+1 year') GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Prediction Result:
('UNITED STATES', 890.0)
('CANADA', 450.0)
('BRAZIL', 135.0)
*/