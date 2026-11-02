INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (0, 'Allison Hill', 'agreement', 'Brand#13', 'rate', 1004, 'WRAP PKG', 1008, 'Last everything thank serve civil.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Noah Rhodes', 'option', 'Brand#13', 'science', 1017.0, 'WRAP PKG', 1025.0, 'Future choice whatever from behavior benefit.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Angie Henderson', 'decide', 'Brand#13', 'offer', 1030.0, 'WRAP PKG', 1042.0, 'Page southern role movie win her.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Daniel Wagner', 'sense', 'Brand#13', 'kind', 1043.0, 'WRAP PKG', 1059.0, 'Fall pick those gun court attorney product.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1012, 'Victoria Wyatt', 'Participant commercial rock clear.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Jamie Chavez', 'Establish understand read detail food shoulder.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Carla Kelly', 'Director allow firm environment.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Mia Sutton', 'Tree note responsibility defense material.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1016, 'Maria Thomas', 1012, 'Before another body physical society instead as.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'Patrick Ryan', 1012, 'Other life edge network wall quite.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'Jessica Silva', 1012, 'Race Mr environment political.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'Zachary Taylor', 1012, 'Fall citizen about reveal.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1020, 'Valerie Gill', 'PSC 0957, Box 0154
APO AE 08093', 1016, '001-899-973-7631x1656', 1024, 'customer', 'Save article finish anyone live try most arm.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1021, 'Ashley Garrett', '71822 Arroyo Expressway
Allisonchester, IL 71187', 1016, '001-801-406-5133x3872', 1037.0, 'fine', 'Bag control organization push dog build three.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1022, 'Katie Gonzalez', '465 Lam Mission
East Jeffreymouth, AK 77611', 1016, '473-817-8108x013', 1050.0, 'director', 'Often always bank price north.');
INSERT INTO "customer" ("c_custkey", "c_name", "c_address", "c_nationkey", "c_phone", "c_acctbal", "c_mktsegment", "c_comment") VALUES (1023, 'Christopher Ashley', '10310 Jones Freeway
Elizabethborough, ND 17843', 1016, '973.460.2606x4746', 1063.0, 'article', 'Various daughter respond draw how public.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1028, 'Eugene Walton', '8498 Elizabeth Plaza
Sarahville, FM 18102', 1016, '431.458.6923', 1032, 'Paper memory history office effort remember.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1029, 'Jimmy Murillo', '824 Jacobs Stravenue
Jamesview, NY 64533', 1016, '(902)756-3421x60733', 1045.0, 'Mind southern rather.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1030, 'Angel Lewis MD', '64005 Dana Greens
Lake Scott, VT 56558', 1016, '733-203-6541x4586', 1058.0, 'Hair attorney professional form finish.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1031, 'Shirley Suarez', '28059 Russell Canyon
Michaelton, MH 47399', 1016, '742-794-0196', 1071.0, 'Rest feel finally impact.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1036, 1020, 'interesting', 1040, '1970-01-01', 'care', 'yard', 1044, 'Past feeling nature a.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1037, 1020, 'same', 1049.0, '1970-01-01', 'dark', 'hundred', 1061.0, 'Decision size parent focus kid.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1038, 1020, 'find', 1058.0, '1970-01-01', 'kitchen', 'research', 1078.0, 'Memory soldier where save probably.');
INSERT INTO "orders" ("o_orderkey", "o_custkey", "o_orderstatus", "o_totalprice", "o_orderdate", "o_orderpriority", "o_clerk", "o_shippriority", "o_comment") VALUES (1039, 1020, 'once', 1067.0, '1970-01-01', 'red', 'smile', 1095.0, 'Middle plan friend stand seem.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (0, 1028, 1048, 1052, 'Different current agency each little.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (0, 1029, 1055.0, 1061.0, 'Lay though offer responsibility.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (0, 1030, 1062.0, 1070.0, 'Manager during prevent accept seem show.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (0, 1031, 1069.0, 1079.0, 'Sing despite sound receive.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1029, 1072, 1073, 'Indeed deal information toward once receive task.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1030, 1074, 1075, 'Herself accept goal send table well industry.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1031, 1076, 1077, 'Son today major event magazine home protect.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 0, 1028, 1056, 0, 1060, 1064, 1068, 'majority', 'whose', '1970-01-01', '1970-01-01', '1970-01-01', 'cell', 'operation', 'Partner rest measure store natural today.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1001, 1029, 1057, 0, 1073.0, 1079.0, 1085.0, 'apply', 'thus', '1970-01-01', '1970-01-01', '1970-01-01', 'suddenly', 'physical', 'Late seem style everyone sing machine dream.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1002, 1030, 1058, 0, 1086.0, 1094.0, 1102.0, 'onto', 'campaign', '1970-01-01', '1970-01-01', '1970-01-01', 'region', 'free', 'Back experience even floor music catch.');
INSERT INTO "lineitem" ("l_orderkey", "l_partkey", "l_suppkey", "l_linenumber", "l_quantity", "l_extendedprice", "l_discount", "l_tax", "l_returnflag", "l_linestatus", "l_shipdate", "l_commitdate", "l_receiptdate", "l_shipinstruct", "l_shipmode", "l_comment") VALUES (1036, 1003, 1031, 1059, 0, 1099.0, 1109.0, 1119.0, 'enjoy', 'loss', '1970-01-01', '1970-01-01', '1970-01-01', 'nice', 'someone', 'Him check degree increase former.');
