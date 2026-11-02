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
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES (1, 'AMERICA', 'comment');
INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES (1, 'UNITED STATES', 1, 'comment');
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES (1, 'Supplier#1', 'Address 1', 1, '111-111-1111', 100.0, 'comment');
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES (1, 'Part 1', 'Mfgr#1', 'Brand#11', 'STANDARD', 10, 'SM CASE', 50.0, 'comment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (1, 'Cust 1', 'Addr 1', 1, '111-111', 1000.0, 'HOUSEHOLD', 'valid');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (2, 'Cust 2', 'Addr 2', 1, '222-222', 1000.0, 'AUTOMOBILE', 'wrong segment');
INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES (3, 'Cust 3', 'Addr 3', 1, '333-333', 1000.0, 'household', 'case check');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (10, 1, 'O', 500.0, '1995-03-28', '1-URGENT', 'Clerk#1', 1, 'valid order 1');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (20, 1, 'O', 600.0, '1995-03-29', '1-URGENT', 'Clerk#1', 1, 'boundary orderdate =');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (30, 1, 'O', 700.0, '1995-03-30', '1-URGENT', 'Clerk#1', 1, 'invalid orderdate >');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (40, 2, 'O', 800.0, '1995-03-20', '1-URGENT', 'Clerk#1', 1, 'wrong cust mktsegment');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) VALUES (50, 3, 'O', 900.0, '1995-03-20', '1-URGENT', 'Clerk#1', 1, 'lowercase mktsegment');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10, 1, 1, 1, 5.0, 100.0, 0.05, 0.02, 'N', 'O', '1995-03-30', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'valid');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10, 1, 1, 2, 10.0, 100.0, 0.10, 0.02, 'N', 'O', '1995-04-01', '1995-04-02', '1995-04-06', 'NONE', 'MAIL', 'valid dup price');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10, 1, 1, 3, 2.0, 250.0, 0.00, 0.02, 'N', 'O', '1995-03-29', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'boundary shipdate =');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (10, 1, 1, 4, 2.0, 300.0, 0.00, 0.02, 'N', 'O', '1995-03-28', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'invalid shipdate <');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (20, 1, 1, 1, 1.0, 400.0, 0.00, 0.02, 'N', 'O', '1995-03-30', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'belongs to boundary order');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (30, 1, 1, 1, 1.0, 500.0, 0.00, 0.02, 'N', 'O', '1995-03-30', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'belongs to late order');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (40, 1, 1, 1, 1.0, 600.0, 0.00, 0.02, 'N', 'O', '1995-03-30', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'belongs to wrong mktsegment');
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) VALUES (50, 1, 1, 1, 1.0, 700.0, 0.00, 0.02, 'N', 'O', '1995-03-30', '1995-04-01', '1995-04-05', 'NONE', 'TRUCK', 'belongs to lowercase mktsegment');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT l_orderkey, SUM(l_extendedprice) AS revenue, o_orderdate, o_shippriority FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE c_mktsegment = 'HOUSEHOLD' AND c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate < '1995-03-29' AND l_shipdate > '1995-03-29' GROUP BY l_orderkey, o_orderdate, o_shippriority ORDER BY revenue DESC NULLS FIRST, o_orderdate NULLS LAST, l_orderkey NULLS LAST, o_shippriority NULLS LAST;

/*
Gold Result:
(10, 200.0, '1995-03-28', 1)
*/

-- Prediction Query
SELECT l_orderkey, SUM(l_extendedprice * (1 - l_discount)) AS revenue, o_orderdate, o_shippriority FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE c_mktsegment = 'HOUSEHOLD' AND c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate < DATE('1995-03-29') AND l_shipdate > DATE('1995-03-29') GROUP BY l_orderkey, o_orderdate, o_shippriority, l_linenumber ORDER BY revenue DESC NULLS FIRST, o_orderdate NULLS LAST, l_orderkey NULLS LAST, o_shippriority NULLS LAST;

/*
Prediction Result:
(10, 95.0, '1995-03-28', 1)
(10, 90.0, '1995-03-28', 1)
*/