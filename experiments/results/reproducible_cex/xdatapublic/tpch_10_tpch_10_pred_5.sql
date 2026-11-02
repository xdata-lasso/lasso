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
insert into region values ('34','MIDDLE EAST','slylyn');
insert into region values ('32','MIDDLE EAST','slylyn');
insert into region values ('31','MIDDLE EAST','slylyn');
insert into region values ('37','MIDDLE EAST','slylyn');
insert into region values ('33','MIDDLE EAST','slylyn');
insert into nation values ('29','ARGENTINA','34','V2');
insert into nation values ('36','ALGERIA','37','haggle');
insert into nation values ('27','ARGENTINA','31','V2');
insert into nation values ('28','ARGENTINA','34','V2');
insert into nation values ('30','ALGERIA','32','V2');
insert into supplier values ('41','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','30','113835161199','-1','. slyly');
insert into customer values ('26','Customer000000002','MG9kdTD2WBHm','28','11719748364','-1','AUTOMOBILE','l accounts');
insert into customer values ('35','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','36','141281905944','-2','MACHINERY ','l accounts');
insert into customer values ('25','Customer000000002','MG9kdTD2WBHm','29','141281905944','0','MACHINERY ',' requests');
insert into orders values ('38','35','O','-3','1993-05-30','5LOW','Clerk000000955','39','asymptot');
insert into orders values ('23','35','F','-1','1993-05-31','5LOW','Clerk000000955','24','nstructions');
insert into part values ('40','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','22','WRAP CASE ','-1','ly');
insert into lineitem values ('38','40','41','42','-1','-1','-1','-1','R','O','1970-02-13','1970-02-14','1970-02-15','DELIVER IN PERSON','SHIP','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_custkey, c_name, SUM(l_extendedprice) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN nation WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate > '1993-03-01' AND o_orderdate < '1993-06-01' AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Gold Result:
(35, 'Customer000000002', -1.0, -2.0, 'ALGERIA', 'XSTf4,NCwDVaWNe6tEgvwfmRchLXak', '141281905944', 'l accounts')
*/

-- Prediction Query
SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer CROSS JOIN orders CROSS JOIN lineitem CROSS JOIN nation WHERE l_orderkey = o_orderkey AND o_orderdate >= DATE('1993-03-01') AND o_orderdate < DATE('1993-03-01', '+3 month') AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST, c_custkey NULLS LAST, c_name NULLS LAST, c_acctbal NULLS LAST, n_name NULLS LAST, c_address NULLS LAST, c_phone NULLS LAST, c_comment NULLS LAST;

/*
Prediction Result:
(25, 'Customer000000002', -2.0, 0.0, 'ARGENTINA', 'MG9kdTD2WBHm', '141281905944', ' requests')
(26, 'Customer000000002', -2.0, -1.0, 'ARGENTINA', 'MG9kdTD2WBHm', '11719748364', 'l accounts')
(35, 'Customer000000002', -2.0, -2.0, 'ALGERIA', 'XSTf4,NCwDVaWNe6tEgvwfmRchLXak', '141281905944', 'l accounts')
*/