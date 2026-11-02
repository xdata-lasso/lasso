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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'MIDDLE EAST', 'Middle East region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'EGYPT', 1, 'Egypt nation');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (11, 'JORDAN', 1, 'Jordan nation');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (100, 'Supplier#100', '100 Nile St', 10, '20-111-111-1111', 500.25, 'Min cost supplier for Part 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (101, 'Supplier#101', '101 Petra Rd', 11, '21-222-222-2222', 900.50, 'Mid cost supplier for Part 1 and min for Part 2');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (102, 'Supplier#102', '102 Cairo Ave', 10, '20-333-333-3333', 1200.00, 'Max cost supplier for Part 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part One Valid', 'Manufacturer#1', 'Brand#11', 'STANDARD BRUSHED TIN', 9, 'SM CASE', 100.00, 'Valid part 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part Two Valid', 'Manufacturer#2', 'Brand#22', 'SMALL POLISHED TIN', 9, 'LG BOX', 200.00, 'Valid part 2');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'Part Three Wrong Size', 'Manufacturer#3', 'Brand#33', 'STANDARD BRUSHED TIN', 8, 'SM CASE', 90.00, 'Wrong size 8');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (4, 'Part Four Wrong Type', 'Manufacturer#4', 'Brand#44', 'STANDARD BRUSHED BRASS', 9, 'SM CASE', 95.00, 'Wrong type brass');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 100, 50, 10.00, 'Min supplycost for Part 1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 101, 40, 20.00, 'Mid supplycost for Part 1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 102, 30, 50.00, 'Max supplycost for Part 1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 101, 60, 35.00, 'Min supplycost for Part 2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 102, 25, 45.00, 'Higher supplycost for Part 2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 100, 10, 1.00, 'Very cheap but wrong p_size');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (4, 100, 10, 2.00, 'Very cheap but wrong p_type');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Gold Result:
(900.5, 'Supplier#101', 'JORDAN', 2, 'Manufacturer#2', '101 Petra Rd', '21-222-222-2222', 'Mid cost supplier for Part 1 and min for Part 2')
(500.25, 'Supplier#100', 'EGYPT', 1, 'Manufacturer#1', '100 Nile St', '20-111-111-1111', 'Min cost supplier for Part 1')
*/

-- Prediction Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Prediction Result:
(1200.0, 'Supplier#102', 'EGYPT', 1, 'Manufacturer#1', '102 Cairo Ave', '20-333-333-3333', 'Max cost supplier for Part 1')
(1200.0, 'Supplier#102', 'EGYPT', 2, 'Manufacturer#2', '102 Cairo Ave', '20-333-333-3333', 'Max cost supplier for Part 1')
(900.5, 'Supplier#101', 'JORDAN', 1, 'Manufacturer#1', '101 Petra Rd', '21-222-222-2222', 'Mid cost supplier for Part 1 and min for Part 2')
(900.5, 'Supplier#101', 'JORDAN', 2, 'Manufacturer#2', '101 Petra Rd', '21-222-222-2222', 'Mid cost supplier for Part 1 and min for Part 2')
(500.25, 'Supplier#100', 'EGYPT', 1, 'Manufacturer#1', '100 Nile St', '20-111-111-1111', 'Min cost supplier for Part 1')
*/