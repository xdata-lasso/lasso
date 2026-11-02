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
insert into region values ('32','MIDDLE EAST','slylyn');
insert into region values ('33','MIDDLE EAST','slylyn');
insert into nation values ('30','ALGERIA','32','haggle');
insert into nation values ('31','ALGERIA','33','haggle');
insert into supplier values ('36','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','30','113835161199','-99998','. slyly');
insert into customer values ('29','Customer000000002','XSTf4,NCwDVaWNe6tEgvwfmRchLXak','30','141281905944','-99997','MACHINERY ','l accounts');
insert into orders values ('34','29','O','-99997','1970-01-28','5LOW','Clerk000000955','28','asymptot');
insert into part values ('35','goldenrod','Manufacturer1 ','Brand23','POLISHED BRASS','2','SM PKG','-99998.0','ly');
insert into part values ('26','goldenrod','Manufacturer1 ','Brand13','POLISHED BRASS','-100000','WRAP CASE ','-99998','ly');
insert into lineitem values ('34','35','36','37','5','-99997','-99998','-99997.0','N','O','1970-02-08','1970-02-09','1970-02-10','DELIVER IN PERSON','AIR REG','requests');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(l_extendedprice) AS revenue FROM lineitem CROSS JOIN part WHERE (p_partkey = l_partkey AND p_brand = 'Brand23' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 15 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand44' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND (l_shipmode = 'AIR') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Gold Result:
(-99997.0,)
*/

-- Prediction Query
SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM lineitem CROSS JOIN part WHERE (p_partkey = l_partkey AND p_brand = 'Brand#23' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 5 AND l_quantity <= 5 + 10 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand#15' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 14 AND l_quantity <= 14 + 10 AND p_size BETWEEN 1 AND 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') AND (p_partkey = l_partkey AND p_brand = 'Brand#44' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 28 AND l_quantity <= 28 + 10 AND p_size BETWEEN 1 AND 15 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON');

/*
Prediction Result:
(None,)
*/