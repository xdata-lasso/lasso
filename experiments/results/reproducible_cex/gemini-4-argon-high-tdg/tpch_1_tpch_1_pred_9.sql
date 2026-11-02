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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'region comment 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'UNITED STATES', 1, 'nation comment 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supplier#000000001', '123 Main St', 1, '11-111-111-1111', 1000.00, 'supplier comment 1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Customer#000000001', '456 Oak Ave', 1, '22-222-222-2222', 2000.00, 'BUILDING', 'customer comment 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part One', 'Manufacturer#1', 'Brand#11', 'STANDARD POLISHED TIN', 10, 'SM BOX', 100.00, 'part comment 1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 500, 50.00, 'partsupp comment 1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1, 1, 'O', 1500.00, '1997-01-01', '1-URGENT', 'Clerk#000000001', 0, 'order comment 1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (2, 1, 'F', 2500.00, '1997-02-01', '2-HIGH', 'Clerk#000000002', 0, 'order comment 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 1, 40.00, 400.00, 0.10, 0.05, 'A', 'O', '1997-06-01', '1997-06-10', '1997-06-15', 'DELIVER IN PERSON', 'TRUCK', 'group AO row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 2, 40.00, 400.00, 0.10, 0.05, 'A', 'O', '1997-06-02', '1997-06-11', '1997-06-16', 'DELIVER IN PERSON', 'TRUCK', 'group AO row 2 duplicate vals');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (2, 1, 1, 1, 70.00, 700.00, 0.25, 0.08, 'A', 'O', '1997-06-03', '1997-06-12', '1997-06-17', 'DELIVER IN PERSON', 'TRUCK', 'group AO row 3 distinct order');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 3, 20.00, 200.00, 0.05, 0.02, 'N', 'F', '1997-07-01', '1997-07-10', '1997-07-15', 'NONE', 'AIR', 'group NF row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (2, 1, 1, 2, 30.00, 300.00, 0.15, 0.06, 'N', 'F', '1997-07-02', '1997-07-11', '1997-07-16', 'NONE', 'AIR', 'group NF row 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 4, 15.00, 150.00, 0.04, 0.03, 'R', 'F', '1997-08-01', '1997-08-10', '1997-08-15', 'TAKE BACK RETURN', 'MAIL', 'group RF row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 5, 5.00, 50.00, 0.01, 0.01, 'R', 'O', '1997-08-02', '1997-08-11', '1997-08-16', 'TAKE BACK RETURN', 'SHIP', 'group RO row 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (2, 1, 1, 3, 999.00, 9999.00, 0.50, 0.50, 'A', 'O', '1999-01-01', '1999-01-10', '1999-01-15', 'NONE', 'RAIL', 'excluded future shipdate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT l_returnflag, l_linestatus, SUM(l_quantity) AS sum_qty, SUM(l_extendedprice) AS sum_base_price, SUM(l_extendedprice) AS sum_disc_price, SUM(l_extendedprice) AS sum_charge, AVG(l_quantity) AS avg_qty, AVG(l_extendedprice) AS avg_price, AVG(l_discount) AS avg_disc, COUNT(l_orderkey) AS count_order FROM lineitem WHERE l_shipdate <= '1998-1-01' GROUP BY l_returnflag, l_linestatus ORDER BY l_returnflag NULLS LAST, l_linestatus NULLS LAST, sum_qty NULLS LAST, sum_base_price NULLS LAST, sum_disc_price NULLS LAST, sum_charge NULLS LAST, avg_qty NULLS LAST, avg_price NULLS LAST, avg_disc NULLS LAST, count_order NULLS LAST;

/*
Gold Result:
('A', 'O', 150.0, 1500.0, 1500.0, 1500.0, 50.0, 500.0, 0.15, 3)
('N', 'F', 50.0, 500.0, 500.0, 500.0, 25.0, 250.0, 0.1, 2)
('R', 'F', 15.0, 150.0, 150.0, 150.0, 15.0, 150.0, 0.04, 1)
('R', 'O', 5.0, 50.0, 50.0, 50.0, 5.0, 50.0, 0.01, 1)
*/

-- Prediction Query
SELECT l_returnflag, l_linestatus, SUM(l_quantity) AS sum_qty, SUM(l_extendedprice) AS sum_base_price, SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price, SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge, AVG(l_quantity) AS avg_qty, AVG(l_extendedprice) AS avg_price, AVG(l_discount) AS avg_disc, COUNT(*) AS count_order FROM lineitem WHERE l_shipdate <= DATE('1998-12-01', '-112 day') GROUP BY l_returnflag, l_linestatus, l_tax ORDER BY l_returnflag NULLS LAST, l_linestatus NULLS LAST, sum_qty NULLS LAST, sum_base_price NULLS LAST, sum_disc_price NULLS LAST, sum_charge NULLS LAST, avg_qty NULLS LAST, avg_price NULLS LAST, avg_disc NULLS LAST, count_order NULLS LAST;

/*
Prediction Result:
('A', 'O', 70.0, 700.0, 525.0, 567.0, 70.0, 700.0, 0.25, 1)
('A', 'O', 80.0, 800.0, 720.0, 756.0, 40.0, 400.0, 0.1, 2)
('N', 'F', 20.0, 200.0, 190.0, 193.8, 20.0, 200.0, 0.05, 1)
('N', 'F', 30.0, 300.0, 255.0, 270.3, 30.0, 300.0, 0.15, 1)
('R', 'F', 15.0, 150.0, 144.0, 148.32, 15.0, 150.0, 0.04, 1)
('R', 'O', 5.0, 50.0, 49.5, 49.995, 5.0, 50.0, 0.01, 1)
*/