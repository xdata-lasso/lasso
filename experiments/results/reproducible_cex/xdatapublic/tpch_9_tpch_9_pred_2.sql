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
insert into region values ('44','MIDDLE EAST','slylyn');
insert into region values ('38','MIDDLE EAST','slylyn');
insert into region values ('39','MIDDLE EAST','slylyn');
insert into region values ('37','MIDDLE EAST','slylyn');
insert into region values ('40','MIDDLE EAST','slylyn');
insert into nation values ('33','ALGERIA','38','V2');
insert into nation values ('34','ARGENTINA','37','V2');
insert into nation values ('35','ARGENTINA','38','V2');
insert into nation values ('43','ALGERIA','44','haggle');
insert into nation values ('36','ALGERIA','40','V2');
insert into supplier values ('24','Supplier000000007 ','89eJ5ksX3ImxJQBvxObC,','35','113835161199','1.0','slylyn');
insert into supplier values ('50','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','43','113835161199','-1','. slyly');
insert into customer values ('32','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','33','141281905944','1.0','MACHINERY ','l accounts');
insert into customer values ('46','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','43','141281905944','1.0','MACHINERY ','l accounts');
insert into orders values ('25','46','O','2.0','1970-01-27','5LOW','Clerk000000951','27','nstructions');
insert into orders values ('48','46','O','1.0','1970-02-11','5LOW','Clerk000000955','47','asymptot');
insert into part values ('22','goldenrod','Manufacturer4 ','Brand13','POLISHED BRASS','23','WRAP CASE ','3.0','egularg');
insert into part values ('49','aapinkaa','Manufacturer1 ','Brand13','POLISHED BRASS','45','WRAP CASE ','2.0','ly');
insert into partsupp values ('49','50','42','0.0','ilent');
insert into lineitem values ('48','49','50','51','1.0','0.0','0.0','0.0','N','O','1970-02-22','1970-02-23','1970-02-24','DELIVER IN PERSON','SHIP','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, o_orderdate AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%pink%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Gold Result:
('ALGERIA', '1970-02-11', 0.0)
*/

-- Prediction Query
SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part CROSS JOIN supplier CROSS JOIN lineitem CROSS JOIN partsupp CROSS JOIN orders CROSS JOIN nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND LOWER(p_name) LIKE LOWER('%pink_')) AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST, sum_profit NULLS LAST;

/*
Prediction Result:
*/