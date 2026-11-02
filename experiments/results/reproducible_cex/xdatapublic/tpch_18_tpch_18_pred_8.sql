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
insert into region values ('31','MIDDLE EAST','slylyn');
insert into region values ('33','MIDDLE EAST','slylyn');
insert into region values ('34','MIDDLE EAST','slylyn');
insert into region values ('32','MIDDLE EAST','slylyn');
insert into nation values ('28','ALGERIA','32','haggle');
insert into nation values ('29','ALGERIA','33','haggle');
insert into nation values ('30','ALGERIA','33','haggle');
insert into nation values ('39','ALGERIA','33','haggle');
insert into supplier values ('41','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','28','113835161199','-99998','. slyly');
insert into customer values ('25','Customer000000004','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','28','11719748364','-99998.0','AUTOMOBILE','l accounts');
insert into customer values ('37','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','39','141281905944','-99998.0','MACHINERY ',' requests');
insert into orders values ('35','37','O','-99998','1970-02-06','1URGENT ','Clerk000000955','38','nstructions');
insert into orders values ('22','37','O','-99997.0','1970-01-24','5LOW','Clerk000000955','24','asymptot');
insert into part values ('40','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','21','WRAP CASE ','-99998.0','ly');
insert into lineitem values ('35','40','41','42','-99998','-99998.0','-99998.0','-99998.0','N','O','1970-02-13','1970-02-14','1970-02-15','DELIVER IN PERSON','SHIP','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey AND o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer CROSS JOIN orders CROSS JOIN lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) OR c_custkey = o_custkey AND o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST, c_name NULLS LAST, c_custkey NULLS LAST, o_orderkey NULLS LAST, SUM(l_quantity) NULLS LAST;

/*
Prediction Result:
('Customer000000002', 37, 35, '1970-02-06', -99998.0, -99998.0)
*/