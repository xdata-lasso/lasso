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
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1029, 'Mary Spencer', '740 Cynthia Village Suite 005
Lake Tina, GA 97655', 1017, '560-573-3754', 1033, 'Attorney professional form finish summer rest.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1030, 'Ashley Humphrey', '011 Amy Village Suite 982
Andersonport, MN 05730', 1017, '8367541458', 1046.0, 'Medical project for recent never.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1031, 'Steve Newton', 'PSC 3315, Box 8692
APO AE 21800', 1017, '8147294019', 1059.0, 'Inside wait quality total past.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1032, 'Douglas Clark', 'Unit 2602 Box 5634
DPO AE 92418', 1017, '001-556-798-1693x4060', 1072.0, 'Image street fight decision size.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1037, 1021, 'policy', 1041, '1996-12-17', 'letter', 'Republican', 1045, 'Probably exist professional people.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1038, 1021, 'real', 1050.0, '1996-12-18', 'letter', 'different', 1062.0, 'Stand seem pull different.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1039, 1021, 'fund', 1059.0, '1996-12-19', 'letter', 'much', 1079.0, 'Challenge animal worker particularly shoulder.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1040, 1021, 'make', 1068.0, '1996-12-20', 'letter', 'material', 1096.0, 'Increase picture create recent manager during prevent.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1029, 1049, 1053, 'Throughout team those.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1030, 1056.0, 1062.0, 'Despite sound receive let newspaper true.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1031, 1063.0, 1071.0, 'Lead soon property write.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1032, 1070.0, 1080.0, 'Fish sense kind spring throughout interview trade knowledge.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1030, 1077, 1078, 'Son today major event magazine home protect.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1031, 1079, 1080, 'Right subject try wonder move trade.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1032, 1081, 1082, 'North agree poor career left anyone here deep.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1001, 1029, 1057, 1061, 1065, 1069, 1073, 'cold', 'listen', '1970-01-01', '1969-12-31', '1970-01-01', 'though', 'star', 'Ever back experience even floor.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1002, 1030, 1058, 1072.0, 1078.0, 1084.0, 1090.0, 'six', 'event', '1970-01-01', '1969-12-31', '1970-01-01', 'public', 'near', 'Ball character him check degree increase former.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1003, 1031, 1059, 1083.0, 1091.0, 1099.0, 1107.0, 'training', 'society', '1970-01-01', '1969-12-31', '1970-01-01', 'factor', 'memory', 'Indeed deal information toward once receive task.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1004, 1032, 1060, 1094.0, 1104.0, 1114.0, 1124.0, 'may', 'end', '1970-01-01', '1969-12-31', '1970-01-01', 'space', 'produce', 'Herself accept goal send table well industry.');
