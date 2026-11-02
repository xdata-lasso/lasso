INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'navajo', 'all', 'mouth', 'decide', 1005, 'offer', 1009, 'Everything thank serve civil institution everyone democratic shake.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'navajo', 'better', 'play', 'sense', 1018.0, 'kind', 1026.0, 'Behavior benefit suggest page.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'navajo', 'discover', 'agreement', 'rate', 1031.0, 'discussion', 1043.0, 'Role movie win.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'navajo', 'early', 'option', 'science', 1044.0, 'list', 1060.0, 'Bad fall pick those gun court.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Matthew Mejia', 'Participant commercial rock clear.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Dr. Sharon James', 'Establish understand read detail food shoulder.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Roy Martin', 'Director allow firm environment.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'Michael Miles', 'Tree note responsibility defense material.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (0, 'INDIA', 1013, 'Central cause seat much section investment on.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'INDIA', 1013, 'Despite young meeting before another body.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'INDIA', 1013, 'Civil quite others his other life edge network.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'INDIA', 1013, 'Quite boy those.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1020, 'Patricia Peterson', '52880 Burns Creek
Natashaport, IA 08093', 0, '001-899-973-7631x1656', 1024, 'customer', 'Save article finish anyone live try most arm.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1021, 'Christopher Smith', '71822 Arroyo Expressway
Allisonchester, IL 71187', 0, '001-801-406-5133x3872', 1037.0, 'fine', 'Bag control organization push dog build three.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1022, 'Michelle Stanton', '465 Lam Mission
East Jeffreymouth, AK 77611', 0, '473-817-8108x013', 1050.0, 'director', 'Often always bank price north.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1023, 'Katie Rodriguez', '10310 Jones Freeway
Elizabethborough, ND 17843', 0, '973.460.2606x4746', 1063.0, 'article', 'Various daughter respond draw how public.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1028, 'Eugene Walton', '8498 Elizabeth Plaza
Sarahville, FM 18102', 0, '431.458.6923', 1032, 'Paper memory history office effort remember.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1029, 'Jimmy Murillo', '824 Jacobs Stravenue
Jamesview, NY 64533', 0, '(902)756-3421x60733', 1045.0, 'Mind southern rather.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1030, 'Angel Lewis MD', '64005 Dana Greens
Lake Scott, VT 56558', 0, '733-203-6541x4586', 1058.0, 'Hair attorney professional form finish.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1031, 'Shirley Suarez', '28059 Russell Canyon
Michaelton, MH 47399', 0, '742-794-0196', 1071.0, 'Rest feel finally impact.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1036, 1020, 'interesting', 1040, '1970-01-01', 'care', 'yard', 1044, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1037, 1020, 'same', 1049.0, '1970-01-01', 'dark', 'hundred', 1061.0, 'Decision size parent focus kid.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1038, 1020, 'find', 1058.0, '1970-01-01', 'kitchen', 'research', 1078.0, 'Memory soldier where save probably.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1039, 1020, 'once', 1067.0, '1970-01-01', 'red', 'smile', 1095.0, 'Middle plan friend stand seem.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1028, 1048, 1052, 'Different current agency each little.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1029, 1055.0, 1061.0, 'Lay though offer responsibility.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1030, 1062.0, 1070.0, 'Manager during prevent accept seem show.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1031, 1069.0, 1079.0, 'Sing despite sound receive.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1029, 1076, 1077, 'Indeed deal information toward once receive task.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1030, 1078, 1079, 'Herself accept goal send table well industry.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1031, 1080, 1081, 'Son today major event magazine home protect.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1001, 1028, 1056, 1060, 1064, 1068, 1072, 'majority', 'whose', '1994-07-02', '1970-01-01', '1970-01-01', 'cell', 'operation', 'Partner rest measure store natural today.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1002, 1029, 1057, 1071.0, 1077.0, 1083.0, 1089.0, 'apply', 'thus', '1994-07-03', '1970-01-01', '1970-01-01', 'suddenly', 'physical', 'Late seem style everyone sing machine dream.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1003, 1030, 1058, 1082.0, 1090.0, 1098.0, 1106.0, 'onto', 'campaign', '1994-07-04', '1970-01-01', '1970-01-01', 'region', 'free', 'Back experience even floor music catch.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1004, 1031, 1059, 1093.0, 1103.0, 1113.0, 1123.0, 'enjoy', 'loss', '1994-07-05', '1970-01-01', '1970-01-01', 'nice', 'someone', 'Him check degree increase former.');
