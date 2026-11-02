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
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (0, 'Allison Hill', 'themselves', 'Brand44', 'drive', 1, 'LG CASE', 1012.5, 'Class great prove reduce raise author.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Noah Rhodes', 'production', 'Brand23', 'spring', 1, 'LG BOX', 1029.5, 'Move each left establish.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Angie Henderson', 'present', 'Brand15', 'figure', 1, 'LG PACK', 1046.5, 'Detail food shoulder argue start source husband.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Daniel Wagner', 'value', 'Brand44', 'base', 1, 'LG PKG', 1063.5, 'Decision wall then fire.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Cristian Santos', 'training', 'Brand23', 'top', 1, 'SM CASE', 1080.5, 'How trip learn enter east no enjoy.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1005, 'Connie Lawrence', 'high', 'Brand15', 'early', 1, 'SM BOX', 1097.5, 'Investment on gun young catch management sense technology.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1006, 'Abigail Shaffer', 'participant', 'Brand44', 'trial', 1, 'SM PACK', 1114.5, 'Physical society instead as.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1007, 'Gina Moore', 'dark', 'Brand23', 'blood', 1, 'SM PKG', 1131.5, 'Other life edge network wall quite.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1008, 'Gabrielle Davis', 'sea', 'Brand15', 'husband', 1, 'MED BAG', 1148.5, 'Race Mr environment political.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1009, 'Ryan Munoz', 'available', 'Brand44', 'fall', 1, 'MED BOX', 1165.5, 'Fall citizen about reveal.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1010, 'Monica Herrera', 'answer', 'Brand23', 'long', 1, 'MED PKG', 1182.5, 'Will seven medical blood personal.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1011, 'Jamie Arnold', 'recently', 'Brand15', 'prove', 1, 'MED PACK', 1199.5, 'Participant check several much single morning a.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1024, 'Alec Hickman', 'Dream drive note bad rule.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1045, 'Brandy Wilson', NULL);
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1025, 'Vanessa Patel', 1024, 'Campaign little near enter.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1043, 'Elizabeth Alvarado', 1045, NULL);
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1026, 'Jenny Lewis', '465 Lam Mission
East Jeffreymouth, AK 77611', 1025, '+1-239-730-1031', 1027.5, 'avoid', 'Draw protect Democrat car very number line.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1028, 'Rhonda Lee', '6670 Bruce Stream Suite 133
New Shane, NE 24551', 1025, '473-817-8108x013', 1029.5, 'Loss ten total clearly able hospital unit.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1034, 'Kristopher Harvey', '3534 Anderson Rue Suite 751
South Christineshire, CT 10103', 1043, '+1-638-442-5135', 1044.5, 'Street region particularly would pressure account.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1030, 1026, 'still', 1031.5, '1970-01-01', 'look', 'feeling', 1032, 'Recent room situation product main couple.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1030, 0, 1028, 1035, 28.0, 1037.5, 1039.5, 1041.5, 'director', 'particularly', '1971-02-02', '1973-04-04', '1975-06-06', 'DELIVER IN PERSON', 'AIR', 'Article finish anyone live try most arm.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1030, 1001, 1034, 1036, 28.0, 1050.5, 1054.5, 1058.5, 'article', 'simply', '1971-02-03', '1973-04-05', '1975-06-07', 'DELIVER IN PERSON', 'AIR REG', 'Bag control organization push dog build three.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(l_extendedprice) AS revenue FROM lineitem CROSS JOIN part WHERE (p_partkey = l_partkey AND p_brand = 'Brand23' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 15 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand44' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Gold Result:
(1037.5,)
*/

-- Prediction Query
SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM lineitem CROSS JOIN part WHERE (p_brand = 'Brand#23' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 5 + 10 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_brand = 'Brand#15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_brand = 'Brand#44' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Prediction Result:
(None,)
*/