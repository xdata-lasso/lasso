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
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (21, 'default2', 'default2', 'Brand35', 'default1', 15, 'ECONOMY BURNISHED%', 20.0, 'Brand35'), (25, 'ECONOMY BURNISHED%', 'default2', 'Brand#35', 'Brand35', 2, 'Brand35', 15.0, 'Brand35'), (22, 'Brand35', 'ECONOMY BURNISHED%', 'Brand35', 'ECONOMY BURNISHED%', 35, 'default1', 3.0, 'Brand35'), (14, '%Customer%Complaints%', 'ECONOMY BURNISHED_', 'default2', '%Customer%Complaints%', 24, '%Customer%Complaints%', 1.0, 'Brand35'), (3, '%Customer%Complaints%', 'default2', 'default2', 'Brand#35', 2, '%Customer%Complaints%', 6.0, 'default2'), (6, 'Brand35', 'default2', 'ECONOMY BURNISHED%', 'Brand35', 14, 'default1', 19.0, 'Brand35');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (20, 'Brand35', 'Brand35'), (15, 'Brand35', 'ECONOMY BURNISHED%'), (34, '%Customer%Complaints%', 'default2'), (32, 'Brand#35', 'ECONOMY BURNISHED_'), (1, 'ECONOMY BURNISHED_', 'default1'), (7, 'Brand35', '%Customer%Complaints%'), (8, 'Brand#35', 'ECONOMY BURNISHED_'), (19, 'default1', 'ECONOMY BURNISHED_'), (6, 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED%'), (33, 'default2', 'Brand#35'), (2, 'ECONOMY BURNISHED_', NULL), (3, 'Brand#35', 'ECONOMY BURNISHED%'), (35, 'ECONOMY BURNISHED_', 'ECONOMY BURNISHED_');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (35, 35, 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED%'), (25, 15, 'Brand35', '%Customer%Complaints%'), (32, 35, 'Brand#35', '%Customer%Complaints%'), (6, 33, 'Brand35', 'Brand#35'), (2, 34, 'ECONOMY BURNISHED%', 'default2'), (8, 34, 'ECONOMY BURNISHED%', NULL), (15, 35, 'ECONOMY BURNISHED%', '%Customer%Complaints%'), (21, 19, 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED%'), (7, 15, 'default1', 'default2'), (24, 33, 'Brand#35', NULL), (13, 7, 'default1', 'Brand35'), (33, 20, 'ECONOMY BURNISHED%', '%Customer%Complaints%'), (34, 19, 'ECONOMY BURNISHED%', '%Customer%Complaints%'), (1, 8, 'ECONOMY BURNISHED%', 'Brand35');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (25, 34, 'default1', 'Brand#35', '%Customer%Complaints%', 32.0, 'default1', 'default1'), (33, 8, 'ECONOMY BURNISHED_', 'default1', 'Brand#35', 33.0, '%Customer%Complaints%', 'Brand35'), (22, 2, '%Customer%Complaints%', 'default2', '%Customer%Complaints%', 20.0, 'ECONOMY BURNISHED_', 'default1'), (20, 1, 'Brand#35', '%Customer%Complaints%', '%Customer%Complaints%', 14.0, 'Brand#35', 'default1');
INSERT INTO supplier (s_suppkey, s_nationkey, s_name, s_address, s_phone, s_acctbal, s_comment) VALUES (8, 2, 'Brand35', 'Brand#35', '%Customer%Complaints%', 22.0, 'ECONOMY BURNISHED%'), (13, 13, 'Brand35', 'default2', 'default2', 33.0, 'ECONOMY BURNISHED%'), (25, 25, 'Brand35', 'default2', 'Brand#35', 20.0, 'default1'), (2, 35, '%Customer%Complaints%', 'Brand35', 'default2', 1.0, 'ECONOMY BURNISHED%'), (24, 2, '%Customer%Complaints%', 'Brand#35', '%Customer%Complaints%', 20.0, '%Customer%Complaints%'), (20, 33, 'default1', '%Customer%Complaints%', 'Brand35', 6.0, 'ECONOMY BURNISHED%'), (1, 34, '%Customer%Complaints%', 'default2', 'Brand#35', 0.0, 'ECONOMY BURNISHED%'), (33, 15, '%Customer%Complaints%', '%Customer%Complaints%', 'default2', 21.0, 'Brand35'), (6, 1, 'default1', 'default1', 'default1', 34.0, 'default1'), (21, 7, 'Brand35', 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED_', 23.0, 'ECONOMY BURNISHED_'), (36, 21, 'Brand#35', 'Brand#35', 'Brand35', 2.0, 'default1'), (35, 13, 'Brand#35', 'Brand35', 'ECONOMY BURNISHED%', 7.0, 'Brand#35'), (14, 24, 'default2', 'Brand35', 'default2', 2.0, 'ECONOMY BURNISHED%'), (32, 34, '%Customer%Complaints%', 'default1', '%Customer%Complaints%', 36.0, 'default2'), (34, 7, 'default2', '%Customer%Complaints%', 'default2', 32.0, 'ECONOMY BURNISHED_'), (3, 15, '%Customer%Complaints%', 'default2', 'ECONOMY BURNISHED_', 8.0, 'default2'), (7, 35, 'ECONOMY BURNISHED%', 'default1', 'default1', 32.0, 'default1'), (15, 24, 'default1', 'default1', 'Brand35', 0.0, 'ECONOMY BURNISHED%');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (6, 13, 36, 0.0, 'default2'), (21, 32, 36, 7.0, 'default1'), (25, 25, 2, 32.0, 'default2'), (25, 1, 19, 33.0, 'default2'), (21, 33, 23, 1.0, 'ECONOMY BURNISHED_'), (6, 14, 35, 14.0, 'ECONOMY BURNISHED_');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Gold Result:
('Brand#35', 'Brand35', 2, 2)
('ECONOMY BURNISHED%', 'Brand35', 14, 2)
*/

-- Prediction Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#35' AND p_type NOT LIKE 'ECONOMY BURNISHED_' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Prediction Result:
('ECONOMY BURNISHED%', 'Brand35', 14, 2)
*/