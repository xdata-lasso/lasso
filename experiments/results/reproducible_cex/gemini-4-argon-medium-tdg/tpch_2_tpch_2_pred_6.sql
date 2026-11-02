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
-- DATASET 2
-- Focus: Subquery correlation on p_partkey, region filtering inside subquery, and MIN(ps_supplycost) vs MAX/AVG/uncorrelated MIN.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'MIDDLE EAST', 'Target region');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'ASIA', 'Other region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'JORDAN', 1, 'ME nation');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (2, 'IRAQ', 1, 'ME nation 2');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (3, 'JAPAN', 2, 'Asia nation');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp_ME_Cheap', 'Addr 1', 1, '111', 1000.00, 'ME 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (2, 'Supp_ME_Expensive', 'Addr 2', 2, '222', 2000.00, 'ME 2');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (3, 'Supp_Asia_SuperCheap', 'Addr 3', 3, '333', 3000.00, 'Asia 1');
-- Part 1: Valid part, min cost in ME is 100.00 (Supp 1), Supp 2 has 200.00, Supp 3 (Asia) has 10.00.
-- If subquery misses r_name = 'MIDDLE EAST', min cost becomes 10.00 and Part 1 is excluded!
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part_One', 'MfgrA', 'BrandA', 'POLISHED TIN', 9, 'BOX', 500.00, 'P1');
-- Part 2: Valid part, min cost in ME is 300.00 (Supp 2), Supp 1 has 400.00.
-- If subquery is uncorrelated (global MIN across all parts in ME = 100.00), Part 2 is excluded!
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part_Two', 'MfgrB', 'BrandB', 'BRUSHED TIN', 9, 'BOX', 600.00, 'P2');
-- Part 3: Invalid part (p_size = 5) with ultra-low cost (5.00) in ME.
-- Tests if uncorrelated subquery picks up invalid parts.
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'Part_Three', 'MfgrC', 'BrandC', 'BRUSHED TIN', 5, 'BOX', 600.00, 'P3');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 100, 100.00, 'Min in ME for P1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 2, 100, 200.00, 'Expensive in ME for P1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 3, 100, 10.00, 'Cheapest overall for P1 but in Asia');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 100, 400.00, 'Expensive in ME for P2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 2, 100, 300.00, 'Min in ME for P2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 1, 100, 5.00, 'Ultra cheap in ME for invalid P3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Gold Result:
(2000.0, 'Supp_ME_Expensive', 'IRAQ', 2, 'MfgrB', 'Addr 2', '222', 'ME 2')
(1000.0, 'Supp_ME_Cheap', 'JORDAN', 1, 'MfgrA', 'Addr 1', '111', 'ME 1')
*/

-- Prediction Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Prediction Result:
(2000.0, 'Supp_ME_Expensive', 'IRAQ', 1, 'MfgrA', 'Addr 2', '222', 'ME 2')
(2000.0, 'Supp_ME_Expensive', 'IRAQ', 2, 'MfgrB', 'Addr 2', '222', 'ME 2')
(1000.0, 'Supp_ME_Cheap', 'JORDAN', 1, 'MfgrA', 'Addr 1', '111', 'ME 1')
(1000.0, 'Supp_ME_Cheap', 'JORDAN', 2, 'MfgrB', 'Addr 1', '111', 'ME 1')
*/