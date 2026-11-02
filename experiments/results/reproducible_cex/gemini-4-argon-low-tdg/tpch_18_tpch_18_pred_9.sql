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
-- DATASET 1: Boundary testing on HAVING SUM(l_quantity) > 314, MAX vs SUM vs COUNT, and multiple lineitems per order
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'comment');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supplier1', 'Addr1', 1, '111-1111', 100.00, 'comment');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part1', 'Mfgr1', 'Brand1', 'Type1', 10, 'BOX', 50.00, 'comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'CustomerA', 'AddrA', 1, '111', 1000.00, 'AUTO', 'c1');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'CustomerB', 'AddrB', 1, '222', 2000.00, 'AUTO', 'c2');
-- Order 101: SUM(l_quantity) = 150 + 164 = 314 (Boundary: exactly 314, should be excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (101, 1, 'O', 500.00, '1995-01-01', '1-URGENT', 'Clerk1', 0, 'o1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 1, 150.00, 1500.00, 0.0, 0.0, 'N', 'O', '1995-01-02', '1995-01-02', '1995-01-02', 'NONE', 'TRUCK', 'l1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (101, 1, 1, 2, 164.00, 1640.00, 0.0, 0.0, 'N', 'O', '1995-01-02', '1995-01-02', '1995-01-02', 'NONE', 'TRUCK', 'l2');
-- Order 102: SUM(l_quantity) = 160 + 155 = 315 (Boundary: 315 > 314, should be included; individual quantities < 314 to catch WHERE l_quantity > 314 mutants; distinct quantities to catch SUM(DISTINCT))
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (102, 1, 'O', 600.00, '1995-01-02', '1-URGENT', 'Clerk1', 0, 'o2');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 1, 160.00, 1600.00, 0.0, 0.0, 'N', 'O', '1995-01-03', '1995-01-03', '1995-01-03', 'NONE', 'TRUCK', 'l3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (102, 1, 1, 2, 155.00, 1550.00, 0.0, 0.0, 'N', 'O', '1995-01-03', '1995-01-03', '1995-01-03', 'NONE', 'TRUCK', 'l4');
-- Order 103: SUM(l_quantity) = 200 + 200 = 400 (Identical quantities to catch SUM(DISTINCT l_quantity))
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (103, 2, 'O', 800.00, '1995-01-03', '1-URGENT', 'Clerk2', 0, 'o3');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 1, 200.00, 2000.00, 0.0, 0.0, 'N', 'O', '1995-01-04', '1995-01-04', '1995-01-04', 'NONE', 'TRUCK', 'l5');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (103, 1, 1, 2, 200.00, 2000.00, 0.0, 0.0, 'N', 'O', '1995-01-04', '1995-01-04', '1995-01-04', 'NONE', 'TRUCK', 'l6');
-- Order 104: Single lineitem with l_quantity = 314.5 (Tests decimal precision > 314 vs > 315)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (104, 2, 'O', 400.00, '1995-01-04', '1-URGENT', 'Clerk2', 0, 'o4');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (104, 1, 1, 1, 314.50, 3145.00, 0.0, 0.0, 'N', 'O', '1995-01-05', '1995-01-05', '1995-01-05', 'NONE', 'TRUCK', 'l7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey AND o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Gold Result:
('CustomerB', 2, 103, '1995-01-03', 800.0, 400.0)
('CustomerA', 1, 102, '1995-01-02', 600.0, 315.0)
('CustomerB', 2, 104, '1995-01-04', 400.0, 314.5)
*/

-- Prediction Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey OR o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Prediction Result:
('CustomerA', 1, 103, '1995-01-03', 800.0, 400.0)
('CustomerB', 2, 103, '1995-01-03', 800.0, 1343.5)
('CustomerA', 1, 102, '1995-01-02', 600.0, 1343.5)
('CustomerB', 2, 102, '1995-01-02', 600.0, 315.0)
('CustomerA', 1, 101, '1995-01-01', 500.0, 314.0)
('CustomerB', 2, 101, '1995-01-01', 500.0, 314.0)
('CustomerA', 1, 104, '1995-01-04', 400.0, 314.5)
('CustomerB', 2, 104, '1995-01-04', 400.0, 1343.5)
*/