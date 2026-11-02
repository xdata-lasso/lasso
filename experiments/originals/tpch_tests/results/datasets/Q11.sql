INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1001, 'John Lewis', 'only', 'clear', 'article', 1019, 'ask', 1023, 'Once me system.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1002, 'Anthony Gray', 'recently', 'customer', 'particularly', 1032.0, 'small', 1040.0, 'Arm meet surface attention.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1003, 'Mrs. Rachel Gibson', 'serious', 'fine', 'simply', 1045.0, 'former', 1057.0, 'Push dog build three.');
INSERT INTO "part" ("p_partkey", "p_name", "p_mfgr", "p_brand", "p_type", "p_size", "p_container", "p_retailprice", "p_comment") VALUES (1004, 'Tyler Cowan', 'message', 'director', 'occur', 1058.0, 'art', 1074.0, 'Often always bank price north.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1015, 'Dean Santiago', 'You available defense enter value thing these.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1016, 'Derek Anderson', 'Expect just myself few worker southern.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1017, 'Joyce Hickman', 'Account stage federal professional voice care break.');
INSERT INTO "region" ("r_regionkey", "r_name", "r_comment") VALUES (1018, 'Alexandra Howell', 'Score choice example decision.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (0, 'ARGENTINA', 1015, 'Level rock pull worker better I.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1008, 'ARGENTINA', 1015, 'Song body court movie cell contain.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1009, 'ARGENTINA', 1015, 'Economic type kitchen technology nearly anything yourself.');
INSERT INTO "nation" ("n_nationkey", "n_name", "n_regionkey", "n_comment") VALUES (1010, 'ARGENTINA', 1015, 'Why unit support.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (0, 'Lindsey Roman', '341 Michelle Light
Shawnstad, GA 49021', 0, '284-651-4627', 1011, 'Sense ready require human public health tonight.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1005, 'Kimberly Dudley', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 0, '728.914.8932x52880', 1024.0, 'Building different full open discover detail audience.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1006, 'Juan Calderon', '76724 John Points Suite 969
Coxberg, NY 65187', 0, '3159430391', 1037.0, 'Arrive attack all form method everything magazine much.');
INSERT INTO "supplier" ("s_suppkey", "s_name", "s_address", "s_nationkey", "s_phone", "s_acctbal", "s_comment") VALUES (1007, 'Shannon Ray', '22691 James Mountain
Tashatown, TX 94967', 0, '882-527-8248', 1050.0, 'Office drug list imagine behind probably great.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1001, 0, 1, 1, 'Agent every development say.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1002, 1005, 1, 1, 'Beautiful instead ahead despite measure ago current.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1003, 1006, 1, 1, 'Information last everything thank serve civil institution.');
INSERT INTO "partsupp" ("ps_partkey", "ps_suppkey", "ps_availqty", "ps_supplycost", "ps_comment") VALUES (1004, 1007, 1, 1, 'Choice whatever from behavior benefit.');
