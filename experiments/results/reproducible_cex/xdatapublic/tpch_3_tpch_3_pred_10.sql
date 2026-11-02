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
insert into region values ('43','MIDDLE EAST','slylyn');
insert into region values ('40','MIDDLE EAST','slylyn');
insert into region values ('41','MIDDLE EAST','slylyn');
insert into region values ('42','MIDDLE EAST','slylyn');
insert into region values ('44','MIDDLE EAST','slylyn');
insert into nation values ('38','ALGERIA','44','haggle');
insert into nation values ('37','ALGERIA','44','haggle');
insert into nation values ('39','ALGERIA','43','haggle');
insert into nation values ('47','ALGERIA','43','haggle');
insert into nation values ('72','ALGERIA','41','haggle');
insert into supplier values ('99','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','72','113835161199','0.0','. slyly');
insert into supplier values ('93','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','39','113835161199','0','. slyly');
insert into supplier values ('76','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','37','113835161199','0.0','. slyly');
insert into customer values ('34','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','39','V4','-1.0','MACHINERY ',' requests');
insert into customer values ('36','Customer000000002','V4','37','V4','0.0','MACHINERY ','l accounts');
insert into customer values ('70','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','72','141281905944','-1','HOUSEHOLD','l accounts');
insert into customer values ('35','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','38','141281905944','0.0','MACHINERY ','V6');
insert into customer values ('45','V5','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','47','11719748364','-1.0','HOUSEHOLD','V5');
insert into orders values ('97','45','O','0.0','1696-03-21','1URGENT ','Clerk000000955','46','V5');
insert into orders values ('73','70','I','0.0','1696-03-22','5LOW','V7','74','asymptot');
insert into orders values ('91','70','O','0.0','1696-03-20','V6','V6','71','asymptot');
insert into part values ('75','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','28','WRAP CASE ','0.0','ly');
insert into part values ('98','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','30','WRAP CASE ','0.0','ly');
insert into part values ('92','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','29','WRAP CASE ','0.0','ly');
insert into lineitem values ('73','75','76','77','0.0','0.0','0.0','0.0','R','F','1995-03-29','1970-03-20','1970-03-21','V4','TRUCK ','V8');
insert into lineitem values ('91','92','93','94','0.0','0.0','0.0','-99998.0','N','D','1995-04-01','1970-04-06','1970-04-07','DELIVER IN PERSON','SHIP','V7');
insert into lineitem values ('97','98','99','100','0.0','0.0','0.0','0','D','O','1995-03-30','1970-04-12','1970-04-13','DELIVER IN PERSON','TRUCK ','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT l_orderkey, SUM(l_extendedprice) AS revenue, o_orderdate, o_shippriority FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE c_mktsegment = 'HOUSEHOLD' AND c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate < '1995-03-29' AND l_shipdate > '1995-03-29' GROUP BY l_orderkey, o_orderdate, o_shippriority ORDER BY revenue DESC NULLS FIRST, o_orderdate NULLS LAST, l_orderkey NULLS LAST, o_shippriority NULLS LAST;

/*
Gold Result:
(91, 0.0, '1696-03-20', 71)
(97, 0.0, '1696-03-21', 46)
*/

-- Prediction Query
SELECT l_orderkey, SUM(l_extendedprice + (1 - l_discount)) AS revenue, o_orderdate, o_shippriority FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE c_mktsegment = 'HOUSEHOLD' AND c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate < DATE('1995-03-29') AND l_shipdate > DATE('1995-03-29') GROUP BY l_orderkey, o_orderdate, o_shippriority, l_linenumber ORDER BY revenue DESC NULLS FIRST, o_orderdate NULLS LAST, l_orderkey NULLS LAST, o_shippriority NULLS LAST;

/*
Prediction Result:
(91, 1.0, '1696-03-20', 71)
(97, 1.0, '1696-03-21', 46)
*/