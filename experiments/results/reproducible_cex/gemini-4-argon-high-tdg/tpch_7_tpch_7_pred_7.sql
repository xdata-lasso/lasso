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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'EUROPE', 'Europe region');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'AMERICA', 'America region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'FRANCE', 1, 'France nation');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (20, 'ARGENTINA', 2, 'Argentina nation');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (101, 'Supplier#101', '10 Rue de Rivoli', 10, '16-111-111-1111', 5000.00, 'French supplier');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (201, 'Customer#201', 'Av Corrientes 123', 20, '11-222-222-2222', 3000.00, 'BUILDING', 'Argentinian customer');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (301, 'Part#301', 'Manufacturer#1', 'Brand#11', 'STANDARD POLISHED TIN', 10, 'SM BOX', 100.00, 'Part comment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (401, 201, 'O', 9999.00, '1995-02-01', '1-URGENT', 'Clerk#001', 0, 'Order 401');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (402, 201, 'F', 8888.00, '1996-01-15', '2-HIGH', 'Clerk#002', 0, 'Order 402');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (401, 301, 101, 1, 5.00, 1000.00, 0.10, 0.05, 'N', 'O', '1995-03-15', '1995-04-01', '1995-04-10', 'DELIVER IN PERSON', 'TRUCK', 'Duplicate volume row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (401, 301, 101, 2, 8.00, 1000.00, 0.10, 0.08, 'N', 'O', '1995-03-15', '1995-04-02', '1995-04-12', 'DELIVER IN PERSON', 'MAIL', 'Duplicate volume row 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (401, 301, 101, 3, 10.00, 500.00, 0.20, 0.06, 'N', 'O', '1995-07-20', '1995-08-01', '1995-08-10', 'DELIVER IN PERSON', 'AIR', 'Same year second date with lower revenue');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (402, 301, 101, 1, 2.00, 200.00, 0.05, 0.04, 'R', 'F', '1996-04-10', '1996-05-01', '1996-05-10', 'NONE', 'SHIP', '1996 row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (402, 301, 101, 2, 3.00, 300.00, 0.00, 0.02, 'A', 'F', '1996-04-10', '1996-05-02', '1996-05-11', 'NONE', 'RAIL', '1996 row 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, l_shipdate AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA')) AND l_shipdate > '1995-01-02' AND l_shipdate < '1996-12-31') AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Gold Result:
('FRANCE', 'ARGENTINA', '1995-03-15', 1800.0)
('FRANCE', 'ARGENTINA', '1995-07-20', 400.0)
('FRANCE', 'ARGENTINA', '1996-04-10', 490.0)
*/

-- Prediction Query
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, CAST(STRFTIME('%Y', l_shipdate) AS INTEGER) AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA') OR (n1.n_name = 'ARGENTINA' OR n2.n_name = 'FRANCE')) AND l_shipdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31')) AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST, revenue NULLS LAST;

/*
Prediction Result:
('FRANCE', 'ARGENTINA', 1995, 2200.0)
('FRANCE', 'ARGENTINA', 1996, 490.0)
*/