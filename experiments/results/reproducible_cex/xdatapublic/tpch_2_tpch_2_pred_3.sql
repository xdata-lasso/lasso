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
insert into region values ('36','EUROPE ','slylyn');
insert into region values ('63','MIDDLE EAST','ges');
insert into region values ('38','EUROPE ','slylyn');
insert into region values ('39','EUROPE ','slylyn');
insert into nation values ('32','ALGERIA','38','V3');
insert into nation values ('62','V6','63','haggle');
insert into nation values ('34','ALGERIA','38','V2');
insert into nation values ('35','ALGERIA','38','V3');
insert into supplier values ('60','Supplier000000001 ','s,4TicNGB4uO6PaSqNBUq','62','339909652201','0','each');
insert into supplier values ('29','Supplier000000007 ','q1,G3Pj6OjIuUYfUoH18BFTKP5aU9bEV3','32','113835161199','0.0','blithely');
insert into part values ('59','sprin','Manufacturer1 ','V3','aaTIN','9','WRAP CASE ','0.0','ly');
insert into part values ('25','goldenrod','V3','Brand13','POLISHED BRASS','26','WRAP CASE ','0.0','egularg');
insert into partsupp values ('25','29','22','-99998.0','nic');
insert into partsupp values ('59','60','61','-99997.0','ilent');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Gold Result:
(0.0, 'Supplier000000001 ', 'V6', 59, 'Manufacturer1 ', 's,4TicNGB4uO6PaSqNBUq', '339909652201', 'each')
*/

-- Prediction Query
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part CROSS JOIN supplier CROSS JOIN partsupp CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 9 AND p_type NOT LIKE '%TIN' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp CROSS JOIN supplier CROSS JOIN nation CROSS JOIN region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'MIDDLE EAST') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST, supplier.s_suppkey NULLS LAST, partsupp.ps_partkey NULLS LAST, partsupp.ps_suppkey NULLS LAST, nation.n_nationkey NULLS LAST, region.r_regionkey NULLS LAST;

/*
Prediction Result:
*/