INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1017, 'Jeffrey Carpenter', 'myself', 'government', 'easy', 1081, 'sure', 1085, 'Worker particularly shoulder lay though.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1018, 'Julie Ramos', 'record', 'better', 'remember', 1094.0, 'decide', 1102.0, 'Create recent manager during prevent accept seem.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1019, 'John Santana', 'property', 'tell', 'force', 1107.0, 'choice', 1119.0, 'Sing despite sound receive.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1020, 'Carolyn Miller', 'president', 'society', 'down', 1120.0, 'any', 1136.0, 'Anyone eat summer lead soon property write.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1073, 'Tiffany Vance', 'Style everyone sing machine dream.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1074, 'Michelle Wagner', 'Back experience even floor music catch.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1075, 'Kimberly Merritt', 'Him check degree increase former.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1076, 'Karen Green', 'Indeed deal information toward once receive task.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1057, 'Anthony Fitzgerald', 1073, 'Organization push dog build.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1058, 'Erik Williams', 1073, 'East organization people information on mission various.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1059, 'Thomas Schmidt', 1073, 'Prove fire enter capital population.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1060, 'Jordan York', 1073, 'First sell authority leader your you available.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1005, 'Carla Gray', '76724 John Points Suite 969
Coxberg, NY 65187', 1057, '991.417.1822', 1061, 'difficult', 'Office drug list imagine behind probably great.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1006, 'Margaret Hawkins DDS', '22691 James Mountain
Tashatown, TX 94967', 1057, '989-363-8346x578', 1074.0, 'notice', 'Level rock pull worker better I.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1007, 'Patty Perez', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 1057, '531.250.9839', 1087.0, 'cause', 'Song body court movie cell contain.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1008, 'Ethan Adams', '809 Burns Creek
Natashaport, IA 08093', 1057, '603-910-5183', 1100.0, 'several', 'Economic type kitchen technology nearly anything yourself.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1021, 'Derek Mahoney', '124 Pamela Summit Apt. 449
Lake Matthew, TX 83631', 1057, '(902)756-3421x60733', 1077, 'We TV perhaps professional.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1022, 'Sherry Wood', '0164 Adam Trail Apt. 427
Hoffmanville, CA 91074', 1057, '733-203-6541x4586', 1090.0, 'Rest feel finally impact.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1023, 'Roy Warner', 'PSC 8059, Box 8262
APO AE 40905', 1057, '742-794-0196', 1103.0, 'Recent never court professor here security.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1024, 'Victoria Valdez', '3315 Dickson Summit
East Michelle, AS 23707', 1057, '(798)816-9340x60883', 1116.0, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1001, 1005, 'purpose', 1009, '1996-11-01', 'face', 'election', 1013, 'Quality throughout beautiful instead.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1002, 1005, 'brother', 1018.0, '1996-11-02', 'face', 'dog', 1030.0, 'Behavior discussion own.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1003, 1005, 'ago', 1027.0, '1996-11-03', 'face', 'chair', 1047.0, 'Current practice nation determine operation speak according.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1004, 1005, 'site', 1036.0, '1996-11-04', 'face', 'since', 1064.0, 'Recently future choice whatever.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1017, 1021, 1065, 1069, 'Why unit support.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1018, 1022, 1072.0, 1078.0, 'Image loss ten total.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1019, 1023, 1079.0, 1087.0, 'Her world enter six.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1020, 1024, 1086.0, 1096.0, 'Expect recent room situation product main couple.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1001, 1017, 1021, 1025, 1029, 1033, 1037, 1041, 'great', 'bill', '0003-11-11', '0003-11-15', '0003-11-19', 'PM', 'show', 'Bad fall pick those gun court.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1002, 1017, 1021, 1026, 1040.0, 1046.0, 1052.0, 1058.0, 'blue', 'her', '0003-11-12', '0003-11-16', '0003-11-20', 'everything', 'machine', 'Animal direction eye bag.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1003, 1017, 1021, 1027, 1051.0, 1059.0, 1067.0, 1075.0, 'best', 'throw', '0003-11-13', '0003-11-17', '0003-11-21', 'surface', 'not', 'Term herself law street class.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1004, 1017, 1021, 1028, 1062.0, 1072.0, 1082.0, 1092.0, 'husband', 'guy', '0003-11-14', '0003-11-18', '0003-11-22', 'animal', 'capital', 'Decide environment view possible participant commercial.');
