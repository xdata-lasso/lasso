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
-- Focus: Subquery correlation, MIN vs MAX/AVG, and region filtering inside the subquery vs outer query.
-- Tests:
-- 1. Non-Middle East supplier has a strictly lower supplycost (5.00) than the cheapest Middle East supplier (25.00) for Part 1. If the subquery omits the region filter, MIN(ps_supplycost) becomes 5.00, and the Middle East supplier (25.00) is lost.
-- 2. Part 2 has a Middle East supplier with a lower global cost (10.00) than Part 1's min cost (25.00). If the subquery omits `p_partkey = ps_partkey`, Part 1 won't match.
-- 3. Multiple Middle East suppliers for Part 1 with different costs (25.00, 50.00, 75.00) to kill MAX, AVG, SUM, or missing subquery mutations.
-- 4. Tie for MIN(ps_supplycost) on Part 3 among two Middle East suppliers (both at 15.00) to ensure both are returned.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'MIDDLE EAST', 'Target');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'ASIA', 'Other');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'IRAQ', 1, 'ME 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (2, 'IRAN', 1, 'ME 2');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (3, 'JAPAN', 2, 'ASIA 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'ME_Supp_Cheap', 'Addr 1', 1, '100-1', 1000.00, 'ME 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (2, 'ME_Supp_Mid', 'Addr 2', 1, '100-2', 2000.00, 'ME 2');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (3, 'ME_Supp_Exp', 'Addr 3', 2, '100-3', 3000.00, 'ME 3');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (4, 'ASIA_Supp_SuperCheap', 'Addr 4', 3, '100-4', 4000.00, 'ASIA 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part 1', 'Mfgr1', 'Brand1', 'COPPER TIN', 9, 'BOX', 50.00, 'P1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part 2', 'Mfgr2', 'Brand2', 'STEEL TIN', 9, 'BOX', 60.00, 'P2');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'Part 3 Tie', 'Mfgr3', 'Brand3', 'NICKEL TIN', 9, 'BOX', 70.00, 'P3');
-- Part 1: Asia supplier has cost 5.00; ME suppliers have 25.00, 50.00, 75.00. True ME min is 25.00.
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 4, 100, 5.00, 'Asia cheapest overall');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 100, 25.00, 'ME cheapest');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 2, 100, 50.00, 'ME mid');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 3, 100, 75.00, 'ME expensive');
-- Part 2: ME supplier has cost 10.00 (cheaper than Part 1s ME min of 25.00, testing correlation).
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 2, 100, 10.00, 'ME cheapest for P2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 3, 100, 20.00, 'ME second for P2');
-- Part 3: Two ME suppliers tied at 15.00.
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 1, 100, 15.00, 'ME tie 1');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 3, 100, 15.00, 'ME tie 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Gold Result:
(3000.0, 'ME_Supp_Exp', 'IRAN', 3, 'Mfgr3', 'Addr 3', '100-3', 'ME 3')
(2000.0, 'ME_Supp_Mid', 'IRAQ', 2, 'Mfgr2', 'Addr 2', '100-2', 'ME 2')
(1000.0, 'ME_Supp_Cheap', 'IRAQ', 1, 'Mfgr1', 'Addr 1', '100-1', 'ME 1')
(1000.0, 'ME_Supp_Cheap', 'IRAQ', 3, 'Mfgr3', 'Addr 1', '100-1', 'ME 1')
*/

-- Prediction Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Prediction Result:
(3000.0, 'ME_Supp_Exp', 'IRAN', 1, 'Mfgr1', 'Addr 3', '100-3', 'ME 3')
(3000.0, 'ME_Supp_Exp', 'IRAN', 2, 'Mfgr2', 'Addr 3', '100-3', 'ME 3')
(3000.0, 'ME_Supp_Exp', 'IRAN', 3, 'Mfgr3', 'Addr 3', '100-3', 'ME 3')
(2000.0, 'ME_Supp_Mid', 'IRAQ', 1, 'Mfgr1', 'Addr 2', '100-2', 'ME 2')
(2000.0, 'ME_Supp_Mid', 'IRAQ', 2, 'Mfgr2', 'Addr 2', '100-2', 'ME 2')
(1000.0, 'ME_Supp_Cheap', 'IRAQ', 1, 'Mfgr1', 'Addr 1', '100-1', 'ME 1')
(1000.0, 'ME_Supp_Cheap', 'IRAQ', 3, 'Mfgr3', 'Addr 1', '100-1', 'ME 1')
*/