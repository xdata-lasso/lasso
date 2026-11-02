INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'orchid', 'dog', 'require', 'begin', 1005, 'all', 1009, 'Own night respond red information last everything.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'orchid', 'chair', 'sit', 'performance', 1018.0, 'better', 1026.0, 'Serve civil institution.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'orchid', 'since', 'wait', 'knowledge', 1031.0, 'discover', 1043.0, 'Choice whatever from behavior benefit.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'orchid', 'blue', 'offer', 'almost', 1044.0, 'early', 1060.0, 'Page southern role movie win her.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Sandra Montgomery', 'Law street class great prove.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Laura Bush', 'Participant commercial rock clear.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Darren Roberts', 'Establish understand read detail food shoulder.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'David Garcia', 'Director allow firm environment.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'Tommy Walter', 1013, 'Investment on gun young catch management sense technology.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'Matthew Foster', 1013, 'Physical society instead as.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'Judy Baker', 1013, 'Other life edge network wall quite.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1020, 'Justin Baker', 1013, 'Race Mr environment political.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1021, 'Jeffrey Chavez', '2880 Burns Creek
Natashaport, IA 08093', 1017, '001-899-973-7631x1656', 1025, 'customer', 'Save article finish anyone live try most arm.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1022, 'Sherri Baker', '71822 Arroyo Expressway
Allisonchester, IL 71187', 1017, '001-801-406-5133x3872', 1038.0, 'fine', 'Bag control organization push dog build three.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1023, 'Cassandra Gaines', '465 Lam Mission
East Jeffreymouth, AK 77611', 1017, '473-817-8108x013', 1051.0, 'director', 'Often always bank price north.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1024, 'Elizabeth Fowler', '10310 Jones Freeway
Elizabethborough, ND 17843', 1017, '973.460.2606x4746', 1064.0, 'article', 'Various daughter respond draw how public.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1029, 'Eugene Walton', '8498 Elizabeth Plaza
Sarahville, FM 18102', 1017, '431.458.6923', 1033, 'Paper memory history office effort remember.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1030, 'Jimmy Murillo', '824 Jacobs Stravenue
Jamesview, NY 64533', 1017, '(902)756-3421x60733', 1046.0, 'Mind southern rather.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1031, 'Angel Lewis MD', '64005 Dana Greens
Lake Scott, VT 56558', 1017, '733-203-6541x4586', 1059.0, 'Hair attorney professional form finish.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1032, 'Shirley Suarez', '28059 Russell Canyon
Michaelton, MH 47399', 1017, '742-794-0196', 1072.0, 'Rest feel finally impact.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1037, 1021, 'interesting', 1041, '1970-01-01', 'care', 'yard', 1045, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1038, 1021, 'same', 1050.0, '1970-01-01', 'dark', 'hundred', 1062.0, 'Decision size parent focus kid.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1039, 1021, 'find', 1059.0, '1970-01-01', 'kitchen', 'research', 1079.0, 'Memory soldier where save probably.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1040, 1021, 'once', 1068.0, '1970-01-01', 'red', 'smile', 1096.0, 'Middle plan friend stand seem.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1029, 1049, 1053, 'Different current agency each little.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1030, 1056.0, 1062.0, 'Lay though offer responsibility.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1031, 1063.0, 1071.0, 'Manager during prevent accept seem show.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1032, 1070.0, 1080.0, 'Sing despite sound receive.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1030, 1077, 1078, 'Indeed deal information toward once receive task.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1031, 1079, 1080, 'Herself accept goal send table well industry.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1032, 1081, 1082, 'Son today major event magazine home protect.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1001, 1029, 1057, 1061, 1065, 1069, 1073, 'majority', 'whose', '1970-01-01', '1970-01-01', '1970-01-01', 'cell', 'operation', 'Partner rest measure store natural today.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1002, 1030, 1058, 1072.0, 1078.0, 1084.0, 1090.0, 'apply', 'thus', '1970-01-01', '1970-01-01', '1970-01-01', 'suddenly', 'physical', 'Late seem style everyone sing machine dream.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1003, 1031, 1059, 1083.0, 1091.0, 1099.0, 1107.0, 'onto', 'campaign', '1970-01-01', '1970-01-01', '1970-01-01', 'region', 'free', 'Back experience even floor music catch.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1037, 1004, 1032, 1060, 1094.0, 1104.0, 1114.0, 1124.0, 'enjoy', 'loss', '1970-01-01', '1970-01-01', '1970-01-01', 'nice', 'someone', 'Him check degree increase former.');
