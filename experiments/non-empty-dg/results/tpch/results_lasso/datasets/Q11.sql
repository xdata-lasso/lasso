INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'Noah Rhodes', 'offer', 'perform', 'according', 1005, 'save', 1009, 'Whatever from behavior benefit suggest.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Angie Henderson', 'kind', 'fall', 'song', 1018.0, 'knowledge', 1026.0, 'Enough analysis least by two bad fall pick.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Daniel Wagner', 'discussion', 'table', 'sure', 1031.0, 'grow', 1043.0, 'Officer relate animal direction eye bag.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Cristian Santos', 'list', 'true', 'collection', 1044.0, 'clearly', 1060.0, 'Term herself law street class.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1013, 'Michael Miles', 'Range successful simply director allow.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1014, 'Andrea Reid', 'Husband at tree note responsibility defense.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Danielle Ford', 'How trip learn enter east no enjoy.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'Timothy Watts', 'Investment on gun young catch management sense technology.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (3, 'ARGENTINA', 1013, 'Physical society instead as.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1017, 'Allison Hill', 1013, 'Other life edge network wall quite.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1018, 'ARGENTINA', 1013, 'Race Mr environment political.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1019, 'Allison Hill', 1013, 'Fall citizen about reveal.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (2, 'Valerie Gill', 'PSC 0957, Box 0154
APO AE 08093', 3, '001-899-973-7631x1656', 1023, 'Father why often my security.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1020, 'Ashley Garrett', '71822 Arroyo Expressway
Allisonchester, IL 71187', 3, '001-801-406-5133x3872', 1036.0, 'Anyone live try most.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1021, 'Katie Gonzalez', '465 Lam Mission
East Jeffreymouth, AK 77611', 3, '473-817-8108x013', 1049.0, 'Whether bag control organization.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1022, 'Christopher Ashley', '10310 Jones Freeway
Elizabethborough, ND 17843', 3, '973.460.2606x4746', 1062.0, 'Identify walk now often always.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 2, -1, -3, 'Information on mission various.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1020, -1, -1, 'Prove fire enter capital population.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1021, -1, 1, 'First sell authority leader your you available.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 1022, -1, -1, 'Media car give attention each.');
