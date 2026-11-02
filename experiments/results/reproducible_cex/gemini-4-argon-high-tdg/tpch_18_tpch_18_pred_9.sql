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
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supplier#1', '123 Supp St', 1, '11-111-111-1111', 100.00, 'supp comment');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part#1', 'Manufacturer#1', 'Brand#11', 'STANDARD POLISHED TIN', 10, 'SM BOX', 50.00, 'part comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (10, 'Customer_A', '10 Cust Ave', 1, '21-111-111-1111', 999.00, 'BUILDING', 'cust 10');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (20, 'Customer_B', '20 Cust Ave', 1, '21-222-222-2222', 150.00, 'AUTOMOBILE', 'cust 20');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 10, 'O', 500.00, '1995-01-10', '1-URGENT', 'Clerk#1', 0, 'exact 314 boundary excluded');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 10, 'F', 200.00, '1995-01-11', '2-HIGH', 'Clerk#1', 0, 'multi lineitem sum 315 > 314 but totalprice < 314');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 20, 'O', 600.00, '1995-01-12', '3-MEDIUM', 'Clerk#2', 0, 'duplicate quantities 160+160=320 vs distinct 160');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 20, 'F', 700.00, '1995-01-13', '3-MEDIUM', 'Clerk#2', 0, 'duplicate quantities 200+200+150=550 vs distinct 350');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (105, 10, 'O', 800.00, '1995-01-14', '1-URGENT', 'Clerk#1', 0, 'one item > 314 and one item < 314');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (106, 20, 'F', 1200.00, '1995-01-15', '1-URGENT', 'Clerk#2', 0, 'high price but low quantity 50');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 1, 157.00, 250.00, 0.00, 0.00, 'N', 'O', '1995-02-01', '1995-02-01', '1995-02-05', 'NONE', 'TRUCK', 'line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 2, 157.00, 250.00, 0.00, 0.00, 'N', 'O', '1995-02-01', '1995-02-01', '1995-02-05', 'NONE', 'TRUCK', 'line 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 1, 100.00, 60.00, 0.00, 0.00, 'R', 'F', '1995-02-02', '1995-02-02', '1995-02-06', 'NONE', 'MAIL', 'line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 2, 110.00, 70.00, 0.00, 0.00, 'R', 'F', '1995-02-02', '1995-02-02', '1995-02-06', 'NONE', 'MAIL', 'line 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 3, 105.00, 70.00, 0.00, 0.00, 'R', 'F', '1995-02-02', '1995-02-02', '1995-02-06', 'NONE', 'MAIL', 'line 3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 1, 160.00, 300.00, 0.00, 0.00, 'N', 'O', '1995-02-03', '1995-02-03', '1995-02-07', 'NONE', 'SHIP', 'line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 2, 160.00, 300.00, 0.00, 0.00, 'N', 'O', '1995-02-03', '1995-02-03', '1995-02-07', 'NONE', 'SHIP', 'line 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 1, 200.00, 250.00, 0.00, 0.00, 'A', 'F', '1995-02-04', '1995-02-04', '1995-02-08', 'NONE', 'AIR', 'line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 2, 200.00, 250.00, 0.00, 0.00, 'A', 'F', '1995-02-04', '1995-02-04', '1995-02-08', 'NONE', 'AIR', 'line 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 3, 150.00, 200.00, 0.00, 0.00, 'A', 'F', '1995-02-04', '1995-02-04', '1995-02-08', 'NONE', 'AIR', 'line 3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 1, 320.00, 700.00, 0.00, 0.00, 'N', 'O', '1995-02-05', '1995-02-05', '1995-02-09', 'NONE', 'RAIL', 'line 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (105, 1, 1, 2, 30.00, 100.00, 0.00, 0.00, 'N', 'O', '1995-02-05', '1995-02-05', '1995-02-09', 'NONE', 'RAIL', 'line 2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (106, 1, 1, 1, 50.00, 1200.00, 0.00, 0.00, 'A', 'F', '1995-02-06', '1995-02-06', '1995-02-10', 'NONE', 'FOB', 'line 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey AND o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Gold Result:
('Customer_A', 10, 105, '1995-01-14', 800.0, 350.0)
('Customer_B', 20, 104, '1995-01-13', 700.0, 550.0)
('Customer_B', 20, 103, '1995-01-12', 600.0, 320.0)
('Customer_A', 10, 102, '1995-01-11', 200.0, 315.0)
*/

-- Prediction Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey OR o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Prediction Result:
('Customer_A', 10, 106, '1995-01-15', 1200.0, 50.0)
('Customer_B', 20, 106, '1995-01-15', 1200.0, 50.0)
('Customer_A', 10, 105, '1995-01-14', 800.0, 1899.0)
('Customer_B', 20, 105, '1995-01-14', 800.0, 350.0)
('Customer_A', 10, 104, '1995-01-13', 700.0, 550.0)
('Customer_B', 20, 104, '1995-01-13', 700.0, 1899.0)
('Customer_A', 10, 103, '1995-01-12', 600.0, 320.0)
('Customer_B', 20, 103, '1995-01-12', 600.0, 1899.0)
('Customer_A', 10, 101, '1995-01-10', 500.0, 314.0)
('Customer_B', 20, 101, '1995-01-10', 500.0, 314.0)
('Customer_A', 10, 102, '1995-01-11', 200.0, 1899.0)
('Customer_B', 20, 102, '1995-01-11', 200.0, 315.0)
*/