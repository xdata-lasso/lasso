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
-- Focus: Date boundaries (1993-12-31, 1994-01-01, 1994-12-31, 1995-01-01), Region filtering ('AMERICA' vs 'EUROPE'), and SUM(DISTINCT) vs SUM(ALL)
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'America region');
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (2, 'EUROPE', 'Europe region');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (10, 'USA', 1, 'United States');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (20, 'CANADA', 1, 'Canada');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (30, 'FRANCE', 2, 'France');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part A', 'Mfgr1', 'Brand1', 'Type1', 10, 'SM BOX', 100.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (100, 'Supp USA', 'Addr 1', 10, '111-1111', 500.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (200, 'Supp CAN', 'Addr 2', 20, '222-2222', 500.00, 'Comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (300, 'Supp FRA', 'Addr 3', 30, '333-3333', 500.00, 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1000, 'Cust USA', 'Addr 1', 10, '111-1111', 500.00, 'AUTO', 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2000, 'Cust CAN', 'Addr 2', 20, '222-2222', 500.00, 'AUTO', 'Comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3000, 'Cust FRA', 'Addr 3', 30, '333-3333', 500.00, 'AUTO', 'Comment');
-- Order on exact lower bound (Included)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (1, 1000, 'F', 200.00, '1994-01-01', '1-URGENT', 'Clerk1', 0, 'Lower bound');
-- Order just before lower bound (Excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (2, 1000, 'F', 500.00, '1993-12-31', '1-URGENT', 'Clerk1', 0, 'Before lower bound');
-- Order just before upper bound (Included)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (3, 2000, 'F', 300.00, '1994-12-31', '1-URGENT', 'Clerk1', 0, 'Before upper bound');
-- Order on exact upper bound (Excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (4, 2000, 'F', 700.00, '1995-01-01', '1-URGENT', 'Clerk1', 0, 'Exact upper bound');
-- Order in valid date range but wrong region (Excluded)
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (5, 3000, 'F', 900.00, '1994-06-15', '1-URGENT', 'Clerk1', 0, 'Wrong region');
-- Two lineitems with identical extendedprice to catch SUM(DISTINCT l_extendedprice)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 100, 1, 5.00, 100.00, 0.05, 0.02, 'N', 'O', '1994-01-02', '1994-01-02', '1994-01-05', 'NONE', 'TRUCK', 'Valid 1');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (1, 1, 100, 2, 5.00, 100.00, 0.00, 0.00, 'N', 'O', '1994-01-02', '1994-01-02', '1994-01-05', 'NONE', 'TRUCK', 'Valid 2 duplicate price');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (2, 1, 100, 1, 5.00, 500.00, 0.00, 0.00, 'N', 'O', '1994-01-02', '1994-01-02', '1994-01-05', 'NONE', 'TRUCK', 'Early order');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (3, 1, 200, 1, 5.00, 300.00, 0.10, 0.05, 'N', 'O', '1994-12-31', '1994-12-31', '1995-01-05', 'NONE', 'TRUCK', 'Valid CAN');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (4, 1, 200, 1, 5.00, 700.00, 0.00, 0.00, 'N', 'O', '1995-01-02', '1995-01-02', '1995-01-05', 'NONE', 'TRUCK', 'Late order');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (5, 1, 300, 1, 5.00, 900.00, 0.00, 0.00, 'N', 'O', '1994-06-20', '1994-06-20', '1994-06-25', 'NONE', 'TRUCK', 'Europe order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_name, SUM(l_extendedprice) AS revenue FROM orders CROSS JOIN supplier CROSS JOIN region CROSS JOIN customer CROSS JOIN nation CROSS JOIN lineitem WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND o_orderdate >= '1994-01-01' AND o_orderdate < '1995-01-01' GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Gold Result:
('CANADA', 300.0)
('USA', 200.0)
*/

-- Prediction Query
SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name > 'AMERICA' AND o_orderdate >= DATE('1994-01-01') AND o_orderdate < DATE('1994-01-01', '+1 year') GROUP BY n_name ORDER BY revenue DESC NULLS FIRST, n_name NULLS LAST;

/*
Prediction Result:
('FRANCE', 900.0)
*/