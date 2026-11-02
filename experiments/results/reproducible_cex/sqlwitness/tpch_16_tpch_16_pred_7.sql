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
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (13, 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED%', 'ECONOMY BURNISHED%', 'Brand#35', 35, 'Brand35', 20.0, 'Brand35'), (1, 'Brand#35', 'default2', 'ECONOMY BURNISHED%', 'default1', 23, 'default1', 8.0, 'Brand#35'), (23, '%Customer%Complaints%', 'default2', '%Customer%Complaints%', '%Customer%Complaints%', 1, 'ECONOMY BURNISHED%', 22.0, '%Customer%Complaints%'), (6, 'Brand#35', 'default1', 'default1', 'default1', 23, 'Brand35', 20.0, 'default2'), (25, 'Brand35', 'Brand35', 'Brand#35', 'default1', 1, 'default2', 36.0, 'ECONOMY BURNISHED%'), (24, '%Customer%Complaints%', '%Customer%Complaints%', 'default1', 'default1', 32, 'default2', 19.0, 'default2'), (2, 'Brand35', 'Brand35', 'default2', 'Brand35', 24, 'Brand#35', 7.0, 'Brand35'), (33, 'default2', 'Brand35', 'default2', 'Brand#35', 35, 'default1', 2.0, 'default1'), (32, 'default1', 'Brand#35', 'Brand#35', 'Brand35', 24, 'default2', 34.0, 'default2');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'Brand35', 'ECONOMY BURNISHED%'), (35, 'default1', 'Brand#35'), (34, 'default1', 'default1'), (8, 'default2', 'ECONOMY BURNISHED%'), (19, 'Brand35', '%Customer%Complaints%'), (33, 'ECONOMY BURNISHED%', 'default2');
INSERT INTO nation (n_nationkey, n_regionkey, n_name, n_comment) VALUES (1, 19, 'ECONOMY BURNISHED%', 'Brand#35'), (3, 1, '%Customer%Complaints%', 'default2'), (19, 35, 'default2', 'ECONOMY BURNISHED%'), (23, 19, 'ECONOMY BURNISHED%', 'default2'), (33, 34, 'default1', NULL), (13, 35, 'default2', NULL), (32, 19, 'default1', 'default2'), (34, 8, 'Brand35', 'Brand35'), (2, 8, 'default2', 'Brand35');
INSERT INTO customer (c_custkey, c_nationkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 23, '%Customer%Complaints%', '%Customer%Complaints%', 'default2', 20.0, 'default1', 'default1'), (20, 32, '%Customer%Complaints%', '%Customer%Complaints%', 'ECONOMY BURNISHED%', 23.0, 'default2', 'Brand#35'), (6, 34, 'default2', 'Brand#35', '%Customer%Complaints%', 13.0, 'Brand#35', 'ECONOMY BURNISHED%'), (2, 19, 'default2', 'Brand#35', 'default1', 20.0, 'default2', 'Brand#35'), (24, 19, 'ECONOMY BURNISHED%', '%Customer%Complaints%', 'default2', 22.0, 'Brand35', 'Brand35'), (32, 13, 'ECONOMY BURNISHED%', 'Brand#35', 'default1', 24.0, '%Customer%Complaints%', '%Customer%Complaints%'), (33, 3, 'default1', 'Brand#35', 'default1', 24.0, 'ECONOMY BURNISHED%', '%Customer%Complaints%');
INSERT INTO supplier (s_suppkey, s_nationkey, s_name, s_address, s_phone, s_acctbal, s_comment) VALUES (32, 13, 'default2', 'default2', '%Customer%Complaints%', 22.0, 'ECONOMY BURNISHED%'), (21, 34, 'Brand#35', 'Brand#35', 'ECONOMY BURNISHED%', 24.0, 'default2'), (36, 19, 'Brand#35', 'ECONOMY BURNISHED%', 'Brand35', 6.0, 'Brand#35'), (35, 13, 'default2', 'default1', 'default2', 21.0, 'Brand35'), (6, 33, 'default2', 'default2', 'Brand35', 14.0, 'Brand#35');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (23, 36, 7, 32.0, '%Customer%Complaints%'), (2, 35, 1, 20.0, 'default1'), (13, 32, 15, 14.0, 'ECONOMY BURNISHED%'), (32, 6, 6, 21.0, 'Brand35'), (25, 36, 14, 15.0, 'ECONOMY BURNISHED%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Gold Result:
('Brand#35', 'Brand35', 24, 1)
('ECONOMY BURNISHED%', 'Brand#35', 35, 1)
('default2', 'Brand35', 24, 1)
*/

-- Prediction Query
SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp CROSS JOIN part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#35' AND p_type NOT LIKE 'ECONOMY BURNISHED%' AND p_size IN (14, 7, 21, 24, 35, 33, 2, 20) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size, p_retailprice ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST;

/*
Prediction Result:
('ECONOMY BURNISHED%', 'Brand#35', 35, 1)
('default2', 'Brand35', 24, 1)
*/