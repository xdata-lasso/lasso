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
-- Tests:
-- 1. Arithmetic calculation: l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity
-- 2. Join disambiguation: Supplier nation vs Customer nation (s_nationkey = n_nationkey vs c_nationkey = n_nationkey)
-- 3. Composite join on partsupp: ps_partkey = l_partkey AND ps_suppkey = l_suppkey (includes decoy partsupp rows)
-- 4. Aggregation: SUM(amount) with duplicate amounts (kills SUM(DISTINCT)) and multiple items per group (kills missing GROUP BY / MAX / MIN)
-- 5. Ordering: nation ASC, o_year DESC
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'Region 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'ALGERIA', 1, 'Supplier Nation 1');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (2, 'BRAZIL', 1, 'Supplier Nation 2');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (3, 'CANADA', 1, 'Customer Nation Decoy');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supp1', 'Addr1', 1, '111', 100.0, 'S1 in ALGERIA');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (2, 'Supp2', 'Addr2', 2, '222', 200.0, 'S2 in BRAZIL');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust1', 'CAddr1', 3, '333', 300.0, 'AUTO', 'C1 in CANADA');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'metallic pink', 'Mfgr1', 'Brand1', 'Type1', 10, 'BOX', 50.0, 'Valid pink at end');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (2, 'pinkish', 'Mfgr2', 'Brand2', 'Type2', 20, 'BAG', 60.0, 'Valid pink at start');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 1, 100, 15.0, 'Target PS for L1/L2');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (1, 2, 100, 999.0, 'Decoy PS: same part, wrong supplier');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 1, 100, 888.0, 'Decoy PS: wrong part, same supplier');
INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES (2, 2, 100, 25.0, 'Target PS for L3/L4');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1, 1, 'O', 500.0, '1995-01-01', '1-URGENT', 'Clerk1', 0, 'Order 1995');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (2, 1, 'O', 600.0, '1996-01-01', '1-URGENT', 'Clerk2', 0, 'Order 1996');
-- Group (ALGERIA, 1995-01-01): Two identical profit amounts (600.0 + 600.0 = 1200.0) to test SUM vs SUM(DISTINCT)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 1, 10.0, 1000.0, 0.25, 0.05, 'N', 'O', '1995-01-02', '1995-01-03', '1995-01-04', 'NONE', 'AIR', '1000*(1-0.25) - 15*10 = 600');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 1, 2, 10.0, 1000.0, 0.25, 0.05, 'N', 'O', '1995-01-02', '1995-01-03', '1995-01-04', 'NONE', 'AIR', 'Identical amount = 600');
-- Group (ALGERIA, 1996-01-01): Tests o_year DESC ordering within same nation
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (2, 1, 1, 1, 4.0, 500.0, 0.10, 0.05, 'N', 'O', '1996-01-02', '1996-01-03', '1996-01-04', 'NONE', 'AIR', '500*(0.9) - 15*4 = 390');
-- Group (BRAZIL, 1995-01-01): Tests nation ASC ordering and negative profit
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 2, 2, 3, 20.0, 400.0, 0.50, 0.05, 'N', 'O', '1995-01-02', '1995-01-03', '1995-01-04', 'NONE', 'AIR', '400*(0.5) - 25*20 = -300');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, o_orderdate AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Gold Result:
('ALGERIA', '1996-01-01', 390.0)
('ALGERIA', '1995-01-01', 1200.0)
('BRAZIL', '1995-01-01', -300.0)
*/

-- Prediction Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND LOWER(p_name) LIKE LOWER('%pink_')) AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Prediction Result:
*/