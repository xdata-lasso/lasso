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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region America');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'EUROPE', 'Region Europe');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'ARGENTINA', 1, 'Argentina in America');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (20, 'BRAZIL', 1, 'Brazil in America');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (30, 'FRANCE', 2, 'France in Europe');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (100, 'Supp_Argentina', 'Addr 100', 10, '11-111-1111', 500.00, 'Valid Supplier');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (200, 'Supp_Brazil', 'Addr 200', 20, '22-222-2222', 600.00, 'Supplier in Brazil');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1000, 'Cust_Brazil_Amer', 'Cust Addr 1', 20, '33-333-3333', 1000.00, 'AUTO', 'Customer in America');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2000, 'Cust_France_Eur', 'Cust Addr 2', 30, '44-444-4444', 1500.00, 'MACHINERY', 'Customer in Europe');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part_Valid', 'Mfgr#1', 'Brand#11', 'ECONOMY BURNISHED TIN', 10, 'SM BOX', 100.00, 'Target part');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part_Invalid', 'Mfgr#2', 'Brand#22', 'STANDARD ANODIZED TIN', 20, 'LG BOX', 200.00, 'Non-target part');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10001, 1000, 'O', 1000.00, '1995-01-01', '1-URGENT', 'Clerk#1', 0, 'Lower boundary date');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10002, 1000, 'O', 2000.00, '1996-12-31', '2-HIGH', 'Clerk#2', 0, 'Upper boundary date');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10003, 1000, 'F', 1500.00, '1994-12-31', '3-MEDIUM', 'Clerk#3', 0, 'Before boundary');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10004, 1000, 'F', 1500.00, '1997-01-01', '3-MEDIUM', 'Clerk#4', 0, 'After boundary');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10005, 2000, 'O', 3000.00, '1995-06-15', '1-URGENT', 'Clerk#5', 0, 'Wrong customer region');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10001, 1, 100, 1, 10.00, 1000.00, 0.10, 0.05, 'N', 'O', '1995-01-10', '1995-01-15', '1995-01-20', 'DELIVER IN PERSON', 'TRUCK', 'Valid row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10002, 1, 100, 1, 20.00, 2000.00, 0.20, 0.05, 'N', 'O', '1997-01-05', '1997-01-10', '1997-01-15', 'DELIVER IN PERSON', 'MAIL', 'Valid row 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10002, 1, 200, 2, 15.00, 1500.00, 0.05, 0.05, 'N', 'O', '1997-01-05', '1997-01-10', '1997-01-15', 'DELIVER IN PERSON', 'SHIP', 'Invalid supplier nation');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10001, 2, 100, 2, 5.00, 500.00, 0.00, 0.05, 'N', 'O', '1995-01-10', '1995-01-15', '1995-01-20', 'DELIVER IN PERSON', 'AIR', 'Invalid part type');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10003, 1, 100, 1, 10.00, 1000.00, 0.10, 0.05, 'R', 'F', '1995-01-02', '1995-01-05', '1995-01-10', 'DELIVER IN PERSON', 'RAIL', 'Invalid early orderdate');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10004, 1, 100, 1, 10.00, 1000.00, 0.10, 0.05, 'N', 'O', '1997-01-05', '1997-01-10', '1997-01-15', 'DELIVER IN PERSON', 'FOB', 'Invalid late orderdate');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10005, 1, 100, 1, 30.00, 3000.00, 0.15, 0.05, 'N', 'O', '1995-06-20', '1995-06-25', '1995-06-30', 'DELIVER IN PERSON', 'TRUCK', 'Invalid customer region');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_year, SUM(volume) / SUM(volume) AS mkt_share FROM (SELECT o_orderdate AS o_year, l_extendedprice * (1 - l_discount) AS volume, n2.n_name AS nation FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 CROSS JOIN region WHERE p_partkey = l_partkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND r_name = 'AMERICA' AND s_nationkey = n2.n_nationkey AND o_orderdate BETWEEN '1995-01-01' AND '1996-12-31' AND p_type = 'ECONOMY BURNISHED TIN' AND n2.n_name = 'ARGENTINA') AS all_nations GROUP BY o_year ORDER BY o_year NULLS LAST, mkt_share NULLS LAST;

/*
Gold Result:
('1995-01-01', 1.0)
('1996-12-31', 1.0)
*/

-- Prediction Query
SELECT o_year, SUM(CASE WHEN nation = 'ARGENTINA' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share FROM (SELECT CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) AS volume, n2.n_name AS nation FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN orders CROSS JOIN customer CROSS JOIN nation AS n1 CROSS JOIN nation AS n2 CROSS JOIN region WHERE p_partkey = l_partkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND r_name = 'AMERICA' AND s_nationkey = n2.n_nationkey AND o_orderdate < DATE('1995-01-01') AND o_orderdate < DATE('1996-12-31') AND p_type = 'ECONOMY BURNISHED TIN') AS all_nations GROUP BY o_year ORDER BY o_year NULLS LAST, mkt_share NULLS LAST;

/*
Prediction Result:
(1994, 1.0)
*/