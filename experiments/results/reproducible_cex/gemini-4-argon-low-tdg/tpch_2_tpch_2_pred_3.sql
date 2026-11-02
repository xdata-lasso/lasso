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
-- Focus: Predicate boundaries on PART (p_size = 9 vs 8, 10) and p_type LIKE '%TIN' (suffix vs prefix/substring/exact), and REGION r_name = 'MIDDLE EAST'.
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'MIDDLE EAST', 'Target region');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'EUROPE', 'Non-target region');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (3, 'MIDDLE EAST ', 'Trailing space region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'EGYPT', 1, 'In Middle East');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (20, 'FRANCE', 2, 'In Europe');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (30, 'JORDAN', 3, 'In Middle East trailing space');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (100, 'Supp_ME', 'Addr 100', 10, '111-111', 500.00, 'Valid supplier');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (200, 'Supp_EU', 'Addr 200', 20, '222-222', 600.00, 'Europe supplier');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (300, 'Supp_ME_Space', 'Addr 300', 30, '333-333', 700.00, 'Trailing space region supplier');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part Valid Suffix', 'Mfgr1', 'Brand1', 'LARGE BRUSHED TIN', 9, 'SM CASE', 100.00, 'Valid');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part Valid Exact', 'Mfgr2', 'Brand2', 'TIN', 9, 'SM CASE', 100.00, 'Valid exact TIN');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'Part Size 8', 'Mfgr3', 'Brand3', 'LARGE BRUSHED TIN', 8, 'SM CASE', 100.00, 'Invalid size 8');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (4, 'Part Size 10', 'Mfgr4', 'Brand4', 'LARGE BRUSHED TIN', 10, 'SM CASE', 100.00, 'Invalid size 10');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (5, 'Part Type Prefix', 'Mfgr5', 'Brand5', 'TIN LARGE', 9, 'SM CASE', 100.00, 'Invalid type prefix');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (6, 'Part Type Mid', 'Mfgr6', 'Brand6', 'LARGE TIN BRUSHED', 9, 'SM CASE', 100.00, 'Invalid type substring');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (7, 'Part Valid 7', 'Mfgr7', 'Brand7', 'SMALL TIN', 9, 'SM CASE', 100.00, 'Valid part for non-ME supplier');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 100, 10, 50.00, 'Should match');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 100, 10, 40.00, 'Should match');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 100, 10, 30.00, 'Filtered by size 8');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (4, 100, 10, 30.00, 'Filtered by size 10');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (5, 100, 10, 30.00, 'Filtered by type TIN LARGE');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (6, 100, 10, 30.00, 'Filtered by type LARGE TIN BRUSHED');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (7, 200, 10, 10.00, 'Filtered by Europe');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (7, 300, 10, 10.00, 'Filtered by trailing space region');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Gold Result:
(500.0, 'Supp_ME', 'EGYPT', 1, 'Mfgr1', 'Addr 100', '111-111', 'Valid supplier')
(500.0, 'Supp_ME', 'EGYPT', 2, 'Mfgr2', 'Addr 100', '111-111', 'Valid supplier')
*/

-- Prediction Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type NOT LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Prediction Result:
(500.0, 'Supp_ME', 'EGYPT', 5, 'Mfgr5', 'Addr 100', '111-111', 'Valid supplier')
(500.0, 'Supp_ME', 'EGYPT', 6, 'Mfgr6', 'Addr 100', '111-111', 'Valid supplier')
*/