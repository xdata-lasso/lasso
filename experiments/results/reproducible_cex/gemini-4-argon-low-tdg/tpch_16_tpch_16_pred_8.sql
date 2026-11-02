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
-- Tests part filter mutations: p_brand <> 'Brand35', p_type NOT LIKE 'ECONOMY BURNISHED%', and p_size IN (14, 7, 21, 24, 35, 33, 2, 20)
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'none');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'USA', 1, 'none');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp1', 'Addr1', 1, '111', 100.0, 'Normal');
-- Valid parts covering the remaining values in the IN list (24, 35, 33, 2, 20) and boundary strings
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'P1', 'M1', 'Brand34', 'ECONOMY ANODIZED', 24, 'BOX', 10.0, 'valid');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'P2', 'M1', 'Brand36', 'LARGE ECONOMY BURNISHED', 35, 'BOX', 10.0, 'valid - prefix before ECONOMY BURNISHED');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'P3', 'M1', 'Brand11', 'STANDARD POLISHED', 33, 'BOX', 10.0, 'valid');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (4, 'P4', 'M1', 'Brand12', 'STANDARD POLISHED', 2, 'BOX', 10.0, 'valid');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (5, 'P5', 'M1', 'Brand13', 'STANDARD POLISHED', 20, 'BOX', 10.0, 'valid');
-- Invalid parts (each violates exactly one predicate)
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (6, 'P6', 'M1', 'Brand35', 'STANDARD POLISHED', 14, 'BOX', 10.0, 'invalid brand');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (7, 'P7', 'M1', 'Brand10', 'ECONOMY BURNISHED BRASS', 14, 'BOX', 10.0, 'invalid type prefix');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (8, 'P8', 'M1', 'Brand10', 'ECONOMY BURNISHED', 14, 'BOX', 10.0, 'invalid type exact');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (9, 'P9', 'M1', 'Brand10', 'STANDARD POLISHED', 15, 'BOX', 10.0, 'invalid size 15');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (10, 'P10', 'M1', 'Brand10', 'STANDARD POLISHED', 1, 'BOX', 10.0, 'invalid size 1');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (11, 'P11', 'M1', 'Brand10', 'STANDARD POLISHED', 34, 'BOX', 10.0, 'invalid size 34');
-- Orphan valid part (not in partsupp) to kill LEFT JOIN mutants
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (12, 'P12', 'M1', 'Brand99', 'STANDARD POLISHED', 14, 'BOX', 10.0, 'orphan');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (4, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (5, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (6, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (7, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (8, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (9, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (10, 1, 5, 1.0, 'ok');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (11, 1, 5, 1.0, 'ok');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Gold Result:
('Brand11', 'STANDARD POLISHED', 33, 1)
('Brand12', 'STANDARD POLISHED', 2, 1)
('Brand13', 'STANDARD POLISHED', 20, 1)
('Brand34', 'ECONOMY ANODIZED', 24, 1)
('Brand36', 'LARGE ECONOMY BURNISHED', 35, 1)
*/

-- Prediction Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size, p_container ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Prediction Result:
('Brand11', 'STANDARD POLISHED', 33, 1)
('Brand12', 'STANDARD POLISHED', 2, 1)
('Brand13', 'STANDARD POLISHED', 20, 1)
('Brand34', 'ECONOMY ANODIZED', 24, 1)
('Brand35', 'STANDARD POLISHED', 14, 1)
('Brand36', 'LARGE ECONOMY BURNISHED', 35, 1)
*/