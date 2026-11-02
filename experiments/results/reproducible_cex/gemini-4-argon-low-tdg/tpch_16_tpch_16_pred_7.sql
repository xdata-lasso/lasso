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
-- Tests COUNT(DISTINCT ps_suppkey) vs COUNT(*), GROUP BY collapsing, and multi-column ORDER BY (supplier_cnt DESC, p_brand ASC, p_type ASC, p_size ASC)
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'none');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'none');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp1', 'Addr1', 1, '111', 100.0, 'Good supplier');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (2, 'Supp2', 'Addr2', 1, '222', 100.0, 'Reliable supplier');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (3, 'Supp3', 'Addr3', 1, '333', 100.0, 'Fast supplier');
-- Group 1: Two parts with identical (p_brand, p_type, p_size), supplied by overlapping suppliers (1, 2) and (1, 3).
-- Total rows = 4, Distinct suppliers = 3.
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part1', 'Mfgr1', 'Brand10', 'STANDARD ANODIZED', 14, 'SM BOX', 10.0, 'c');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'Part2', 'Mfgr1', 'Brand10', 'STANDARD ANODIZED', 14, 'SM BOX', 20.0, 'c');
-- Group 2: Tie-breaker on p_size (7 vs 21) with supplier_cnt = 1
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'Part3', 'Mfgr1', 'Brand10', 'STANDARD ANODIZED', 7, 'SM BOX', 10.0, 'c');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (4, 'Part4', 'Mfgr1', 'Brand10', 'STANDARD ANODIZED', 21, 'SM BOX', 10.0, 'c');
-- Group 3: Tie-breaker on p_type ('STANDARD BRUSHED' vs 'STANDARD ANODIZED') with supplier_cnt = 1
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (5, 'Part5', 'Mfgr1', 'Brand10', 'STANDARD BRUSHED', 7, 'SM BOX', 10.0, 'c');
-- Group 4: Tie-breaker on p_brand ('Brand20' vs 'Brand10') with supplier_cnt = 1
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (6, 'Part6', 'Mfgr1', 'Brand20', 'STANDARD ANODIZED', 7, 'SM BOX', 10.0, 'c');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 2, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 3, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 1, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (4, 1, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (5, 1, 10, 5.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (6, 1, 10, 5.0, 'ok');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Gold Result:
('Brand10', 'STANDARD ANODIZED', 14, 3)
('Brand10', 'STANDARD ANODIZED', 7, 1)
('Brand10', 'STANDARD ANODIZED', 21, 1)
('Brand10', 'STANDARD BRUSHED', 7, 1)
('Brand20', 'STANDARD ANODIZED', 7, 1)
*/

-- Prediction Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size, p_retailprice ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Prediction Result:
('Brand10', 'STANDARD ANODIZED', 14, 2)
('Brand10', 'STANDARD ANODIZED', 14, 2)
('Brand10', 'STANDARD ANODIZED', 7, 1)
('Brand10', 'STANDARD ANODIZED', 21, 1)
('Brand10', 'STANDARD BRUSHED', 7, 1)
('Brand20', 'STANDARD ANODIZED', 7, 1)
*/