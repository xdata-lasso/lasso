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
insert into region values ('27','MIDDLE EAST','slylyn');
insert into region values ('28','MIDDLE EAST','slylyn');
insert into nation values ('25','ALGERIA','28','haggle');
insert into nation values ('26','ALGERIA','27','haggle');
insert into supplier values ('31','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','26','113835161199','-99998.0','. slyly');
insert into customer values ('24','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','25','141281905944','-99998.0','MACHINERY ','l accounts');
insert into orders values ('29','24','O','-99998.0','1970-01-23','5LOW','Clerk000000955','23','asymptot');
insert into part values ('30','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','21','WRAP CASE ','-99998.0','ly');
insert into lineitem values ('29','30','31','32','-99998.0','-99998.0','0.0','-99998.0','N','O','1994-01-01','1970-02-03','1970-02-04','DELIVER IN PERSON','SHIP','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(l_extendedprice) AS revenue FROM lineitem WHERE l_shipdate >= '1994-01-01' AND l_shipdate < '1995-01-01' AND l_discount BETWEEN 0.02 AND 0.04 AND l_quantity < 24;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(l_extendedprice * l_discount) AS revenue FROM lineitem WHERE l_shipdate >= DATE('1994-01-01') AND l_shipdate < DATE('1994-01-01', '+1 year') OR l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01 AND l_quantity < 24;

/*
Prediction Result:
(0.0,)
*/