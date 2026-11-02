INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Allison Hill', 'agreement', 'rate', 'discussion', 1005, 'table', 1009, 'Recently future choice whatever.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Noah Rhodes', 'option', 'science', 'list', 1018.0, 'true', 1026.0, 'Bill here grow gas enough analysis.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Angie Henderson', 'decide', 'offer', 'perform', 1031.0, 'according', 1043.0, 'Movie win her need stop peace technology.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Daniel Wagner', 'sense', 'kind', 'fall', 1044.0, 'song', 1060.0, 'Court attorney product significant world talk term.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Jesse Flowers', 'Here writer policy news range successful simply.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Henry Santiago', 'Start source husband at tree.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Melinda Jones', 'Then fire pretty how trip learn enter.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'Kimberly Sanchez', 'Seat much section investment on.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'ETHIOPIA', 1013, 'Despite young meeting before another body.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'JAPAN', 1013, 'Civil quite others his other life edge network.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'ETHIOPIA', 1013, 'Quite boy those.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1020, 'JAPAN', 1013, 'Shoulder future fall citizen about.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1021, 'JAPAN', 1013, 'Will seven medical blood personal.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1022, 'ETHIOPIA', 1013, 'Participant check several much single morning a.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1023, 'JAPAN', 1013, 'Major born guy world southern dream.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1024, 'ETHIOPIA', 1013, 'There water beat magazine attorney.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1025, 'Pamela Anderson', '8713 Caleb Brooks Apt. 930
Lake Crystalbury, CA 04618', 1021, '908-501-3267', 1029, 'particular', 'Information on mission various.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1026, 'Joshua Baker', '347 Amber Stream
Sanchezfort, AS 53855', 1021, '(502)660-6474x6872', 1042.0, 'phone', 'Prove fire enter capital population.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1027, 'Jenny Lewis', '656 Owens Stream
Lake Deniseville, AR 53273', 1021, '909.480.5009', 1055.0, 'among', 'First sell authority leader your you available.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1028, 'Monica Harris', '33872 White Mountain
Port Sandra, NV 72633', 1021, '3815219136', 1068.0, 'president', 'Media car give attention each.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1033, 'Jeffrey Daniels', '824 Jacobs Stravenue
Jamesview, NY 64533', 1017, '(902)756-3421x60733', 1037, 'We TV perhaps professional.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1034, 'William Roman', '64005 Dana Greens
Lake Scott, VT 56558', 1017, '733-203-6541x4586', 1050.0, 'Rest feel finally impact.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1035, 'Mary Spencer', '28059 Russell Canyon
Michaelton, MH 47399', 1017, '742-794-0196', 1063.0, 'Recent never court professor here security.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1036, 'Ashley Humphrey', '158 Dickson Summit
East Michelle, AS 23707', 1017, '(798)816-9340x60883', 1076.0, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1041, 1025, 'few', 1045, '1970-01-01', 'particularly', 'make', 1049, 'List top somebody college be middle plan.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1042, 1025, 'develop', 1054.0, '1970-01-01', 'policy', 'letter', 1066.0, 'Behavior weight dog financial southern challenge.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1043, 1025, 'law', 1063.0, '1970-01-01', 'real', 'Republican', 1083.0, 'Each little sure.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1044, 1025, 'stock', 1072.0, '1970-01-01', 'fund', 'different', 1100.0, 'Lay though offer responsibility.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1033, 1053, 1057, 'Manager during prevent accept seem show.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1034, 1060.0, 1066.0, 'Sing despite sound receive.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1035, 1067.0, 1075.0, 'Anyone eat summer lead soon property write.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1036, 1074.0, 1084.0, 'Fish sense kind spring throughout interview trade knowledge.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1034, 1081, 1082, 'Son today major event magazine home protect.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1035, 1083, 1084, 'Right subject try wonder move trade.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1036, 1085, 1086, 'North agree poor career left anyone here deep.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1001, 1033, 1061, 1065, 1069, 1073, 1077, 'cold', 'listen', '1970-01-01', '1970-01-01', '1970-01-01', 'though', 'star', 'Ever back experience even floor.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1002, 1034, 1062, 1076.0, 1082.0, 1088.0, 1094.0, 'six', 'event', '1970-01-01', '1970-01-01', '1970-01-01', 'public', 'near', 'Ball character him check degree increase former.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1003, 1035, 1063, 1087.0, 1095.0, 1103.0, 1111.0, 'training', 'society', '1970-01-01', '1970-01-01', '1970-01-01', 'factor', 'memory', 'Indeed deal information toward once receive task.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1041, 1004, 1036, 1064, 1098.0, 1108.0, 1118.0, 1128.0, 'may', 'end', '1970-01-01', '1970-01-01', '1970-01-01', 'space', 'produce', 'Herself accept goal send table well industry.');
