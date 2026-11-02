INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Allison Hill', 'agreement', 'rate', 'LARGE BRUSHED NICKEL', 1005, 'discussion', 1009, 'Serve civil institution.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Noah Rhodes', 'option', 'science', 'LARGE BRUSHED NICKEL', 1018.0, 'list', 1026.0, 'Choice whatever from behavior benefit.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Angie Henderson', 'decide', 'offer', 'LARGE BRUSHED NICKEL', 1031.0, 'perform', 1043.0, 'Page southern role movie win her.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Daniel Wagner', 'sense', 'kind', 'LARGE BRUSHED NICKEL', 1044.0, 'fall', 1060.0, 'Fall pick those gun court attorney product.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'ASIA', 'World talk term herself law.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'ASIA', 'Class great prove reduce raise author.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'ASIA', 'Move each left establish.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'ASIA', 'Detail food shoulder argue start source husband.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'Thomas Bradley', 1013, 'Investment on gun young catch management sense technology.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'Christy Porter', 1013, 'Physical society instead as.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'Maria Thomas', 1013, 'Other life edge network wall quite.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1020, 'Patrick Ryan', 1013, 'Race Mr environment political.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1021, 'Jeffrey Chavez', 1013, 'Current hear claim well two truth out major.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1022, 'Sherri Baker', 1013, 'Upon these story film.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1023, 'Cassandra Gaines', 1013, 'Drive note bad rule.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1024, 'Elizabeth Fowler', 1013, 'Within mouth call process.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1025, 'Carmen Rose', 'PSC 7133, Box 1509
APO AP 30662', 1017, '(362)247-3178', 1029, 'authority', 'Identify walk now often always.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1026, 'Tracey Hickman', '03105 Willie Harbors
Lewisberg, VA 75348', 1017, '+1-880-213-2677x3602', 1042.0, 'physical', 'Information on mission various.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1027, 'Melissa Marquez', '6311 Gomez Loop
Shieldston, TX 86150', 1017, '(247)746-8723x4309', 1055.0, 'author', 'Prove fire enter capital population.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1028, 'Michael Brooks', 'Unit 1065 Box 1333
DPO AP 59301', 1017, '3094788208', 1068.0, 'Republican', 'First sell authority leader your you available.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1033, 'Derek Mahoney', '124 Pamela Summit Apt. 449
Lake Matthew, TX 83631', 1021, '(902)756-3421x60733', 1037, 'We TV perhaps professional.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1034, 'Sherry Wood', '0164 Adam Trail Apt. 427
Hoffmanville, CA 91074', 1021, '733-203-6541x4586', 1050.0, 'Rest feel finally impact.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1035, 'Roy Warner', 'PSC 8059, Box 8262
APO AE 40905', 1021, '742-794-0196', 1063.0, 'Recent never court professor here security.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1036, 'Victoria Valdez', '3315 Dickson Summit
East Michelle, AS 23707', 1021, '(798)816-9340x60883', 1076.0, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1041, 1025, 'few', 1045, '1970-01-01', 'particularly', 'make', 1049, 'Soldier where save probably exist professional people.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1042, 1025, 'develop', 1054.0, '1970-01-01', 'policy', 'letter', 1066.0, 'Stand seem pull different.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1043, 1025, 'law', 1063.0, '1970-01-01', 'real', 'different', 1083.0, 'Challenge animal worker particularly shoulder.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1044, 1025, 'stock', 1072.0, '1970-01-01', 'fund', 'much', 1100.0, 'Increase picture create recent manager during prevent.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1033, 1053, 1057, 'Throughout team those.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1034, 1060.0, 1066.0, 'Despite sound receive let newspaper true.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1035, 1067.0, 1075.0, 'Lead soon property write.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1036, 1074.0, 1084.0, 'Fish sense kind spring throughout interview trade knowledge.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1034, 1081, 1082, 'Son today major event magazine home protect.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1035, 1083, 1084, 'Right subject try wonder move trade.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1036, 1085, 1086, 'North agree poor career left anyone here deep.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1001, 1033, 1061, 1065, 1069, 1073, 1077, 'cold', 'listen', '1970-01-01', '1970-01-01', '1970-01-01', 'though', 'star', 'Ever back experience even floor.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1002, 1034, 1062, 1076.0, 1082.0, 1088.0, 1094.0, 'six', 'event', '1970-01-01', '1970-01-01', '1970-01-01', 'public', 'near', 'Ball character him check degree increase former.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1003, 1035, 1063, 1087.0, 1095.0, 1103.0, 1111.0, 'training', 'society', '1970-01-01', '1970-01-01', '1970-01-01', 'factor', 'memory', 'Indeed deal information toward once receive task.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1004, 1036, 1064, 1098.0, 1108.0, 1118.0, 1128.0, 'may', 'end', '1970-01-01', '1970-01-01', '1970-01-01', 'space', 'produce', 'Herself accept goal send table well industry.');
