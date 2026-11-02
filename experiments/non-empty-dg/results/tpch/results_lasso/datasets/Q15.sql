INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Allison Hill', 'agreement', 'rate', 'discussion', 1005, 'table', 1009, 'Recently future choice whatever.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Noah Rhodes', 'option', 'science', 'list', 1018.0, 'true', 1026.0, 'Bill here grow gas enough analysis.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Angie Henderson', 'decide', 'offer', 'perform', 1031.0, 'according', 1043.0, 'Movie win her need stop peace technology.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Daniel Wagner', 'sense', 'kind', 'fall', 1044.0, 'song', 1060.0, 'Court attorney product significant world talk term.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Jesse Flowers', 'Here writer policy news range successful simply.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Henry Santiago', 'Start source husband at tree.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Melinda Jones', 'Then fire pretty how trip learn enter.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'Kimberly Sanchez', 'Seat much section investment on.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'Zachary Taylor', 1013, 'Wife team activity result race.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'Peter Callahan Jr.', 1013, 'Seem shoulder future fall citizen about reveal.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'Michael Carlson', 1013, 'Will seven medical blood personal.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1020, 'Kyle Mcdonald', 1013, 'Participant check several much single morning a.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1021, 'Alec Hickman', '78248 Brandt Plains
Lake Larry, TN 85681', 1017, '517.481.0801', 1025, 'president', 'Mission various daughter respond draw how public.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1022, 'Sandra Parker', '33150 Brianna Avenue Apt. 031
Port Markhaven, IA 37001', 1017, '(977)436-0260x64746', 1038.0, 'beat', 'Lead upon very act perform.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1023, 'Shawn Arroyo', '299 Sanchez Mountains
Leeville, TN 56999', 1017, '243.909.8050', 1051.0, 'really', 'You available defense enter value thing these.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1024, 'John Jones', '0106 Mcbride Coves Apt. 338
Taylorburgh, KY 61138', 1017, '582.208.1219x13619', 1064.0, 'past', 'Expect just myself few worker southern.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (0, 'Mary Spencer', '740 Cynthia Village Suite 005
Lake Tina, GA 97655', 1017, '560-573-3754', 1032, 'Attorney professional form finish summer rest.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1029, 'Ashley Humphrey', '011 Amy Village Suite 982
Andersonport, MN 05730', 1017, '8367541458', 1045.0, 'Medical project for recent never.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1030, 'Steve Newton', 'PSC 3315, Box 8692
APO AE 21800', 1017, '8147294019', 1058.0, 'Inside wait quality total past.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1031, 'Douglas Clark', 'Unit 2602 Box 5634
DPO AE 92418', 1017, '001-556-798-1693x4060', 1071.0, 'Image street fight decision size.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1036, 1021, 'policy', 1040, '1970-01-01', 'letter', 'material', 1044, 'Probably exist professional people.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1037, 1021, 'real', 1049.0, '1970-01-01', 'Republican', 'student', 1061.0, 'Stand seem pull different.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1038, 1021, 'fund', 1058.0, '1970-01-01', 'different', 'wear', 1078.0, 'Challenge animal worker particularly shoulder.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1039, 1021, 'make', 1067.0, '1970-01-01', 'much', 'style', 1095.0, 'Increase picture create recent manager during prevent.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 0, 1048, 1052, 'Throughout team those.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1029, 1055.0, 1061.0, 'Despite sound receive let newspaper true.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1030, 1062.0, 1070.0, 'Lead soon property write.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1031, 1069.0, 1079.0, 'Fish sense kind spring throughout interview trade knowledge.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1029, 1076, 1077, 'Son today major event magazine home protect.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1030, 1078, 1079, 'Right subject try wonder move trade.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1031, 1080, 1081, 'North agree poor career left anyone here deep.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1001, 0, 1056, 1060, 1064, 1068, 1072, 'cold', 'listen', '1997-06-16', '1970-01-01', '1970-01-01', 'though', 'star', 'Ever back experience even floor.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1002, 1029, 1057, 1071.0, 1077.0, 1083.0, 1089.0, 'six', 'event', '1997-06-17', '1970-01-01', '1970-01-01', 'public', 'near', 'Ball character him check degree increase former.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1003, 1030, 1058, 1082.0, 1090.0, 1098.0, 1106.0, 'training', 'society', '1997-06-18', '1970-01-01', '1970-01-01', 'factor', 'memory', 'Indeed deal information toward once receive task.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1004, 1031, 1059, 1093.0, 1103.0, 1113.0, 1123.0, 'may', 'end', '1997-06-19', '1970-01-01', '1970-01-01', 'space', 'produce', 'Herself accept goal send table well industry.');
