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
-- Focus: Part table predicate boundaries (p_brand <> 'Brand35', p_type NOT LIKE 'ECONOMY BURNISHED%', and p_size IN list).
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'EUROPE', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'FRANCE', 1, 'Nation 1');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp1', 'Addr1', 1, '111-1111', 100.0, 'Normal comment');
-- Excluded: p_brand = 'Brand35'
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'P1', 'M1', 'Brand35', 'STANDARD ANODIZED', 14, 'BOX', 10.0, 'C');
-- Included: p_brand close to 'Brand35'
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'P2', 'M1', 'Brand34', 'STANDARD ANODIZED', 7, 'BOX', 10.0, 'C');
-- Excluded: p_type starts with 'ECONOMY BURNISHED'
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (3, 'P3', 'M1', 'Brand10', 'ECONOMY BURNISHED BRASS', 21, 'BOX', 10.0, 'C');
-- Excluded: p_type is exact match 'ECONOMY BURNISHED'
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (4, 'P4', 'M1', 'Brand10', 'ECONOMY BURNISHED', 24, 'BOX', 10.0, 'C');
-- Included: p_type has prefix before 'ECONOMY BURNISHED' (tests 'ECONOMY BURNISHED%' vs '%ECONOMY BURNISHED%')
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (5, 'P5', 'M1', 'Brand11', 'SUPER ECONOMY BURNISHED', 35, 'BOX', 10.0, 'C');
-- Included: p_type shares only partial prefix
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (6, 'P6', 'M1', 'Brand12', 'ECONOMY PLATED BRASS', 33, 'BOX', 10.0, 'C');
-- Included: remaining valid p_size values (2, 20, 14, 21, 24)
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (7, 'P7', 'M1', 'Brand13', 'SMALL BRUSHED', 2, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (8, 'P8', 'M1', 'Brand14', 'SMALL BRUSHED', 20, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (9, 'P9', 'M1', 'Brand15', 'SMALL BRUSHED', 14, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (10, 'P10', 'M1', 'Brand16', 'SMALL BRUSHED', 21, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (11, 'P11', 'M1', 'Brand17', 'SMALL BRUSHED', 24, 'BOX', 10.0, 'C');
-- Excluded: invalid p_size boundary values (1, 3, 6, 8, 13, 15, 19, 22, 23, 25, 32, 34, 36)
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (12, 'P12', 'M1', 'Brand18', 'SMALL BRUSHED', 1, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (13, 'P13', 'M1', 'Brand19', 'SMALL BRUSHED', 15, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (14, 'P14', 'M1', 'Brand20', 'SMALL BRUSHED', 34, 'BOX', 10.0, 'C');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (15, 'P15', 'M1', 'Brand21', 'SMALL BRUSHED', 36, 'BOX', 10.0, 'C');
-- Link all parts to supplier 1
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (3, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (4, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (5, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (6, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (7, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (8, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (9, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (10, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (11, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (12, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (13, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (14, 1, 5, 1.0, 'C');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (15, 1, 5, 1.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Gold Result:
('Brand11', 'SUPER ECONOMY BURNISHED', 35, 1)
('Brand12', 'ECONOMY PLATED BRASS', 33, 1)
('Brand13', 'SMALL BRUSHED', 2, 1)
('Brand14', 'SMALL BRUSHED', 20, 1)
('Brand15', 'SMALL BRUSHED', 14, 1)
('Brand16', 'SMALL BRUSHED', 21, 1)
('Brand17', 'SMALL BRUSHED', 24, 1)
('Brand34', 'STANDARD ANODIZED', 7, 1)
*/

-- Prediction Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#35' AND p_type NOT LIKE 'ECONOMY BURNISHED_' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Prediction Result:
('Brand10', 'ECONOMY BURNISHED', 24, 1)
('Brand10', 'ECONOMY BURNISHED BRASS', 21, 1)
('Brand11', 'SUPER ECONOMY BURNISHED', 35, 1)
('Brand12', 'ECONOMY PLATED BRASS', 33, 1)
('Brand13', 'SMALL BRUSHED', 2, 1)
('Brand14', 'SMALL BRUSHED', 20, 1)
('Brand15', 'SMALL BRUSHED', 14, 1)
('Brand16', 'SMALL BRUSHED', 21, 1)
('Brand17', 'SMALL BRUSHED', 24, 1)
('Brand34', 'STANDARD ANODIZED', 7, 1)
('Brand35', 'STANDARD ANODIZED', 14, 1)
*/