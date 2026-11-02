-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483648, 582.588439, '5k5swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'par_533b04', 'rwbbp6luhvd');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483647, 179.378884, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'par_533b04', 'a9000t5c4eci');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483646, 734.586266, 'ce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 'par_533b04', '2eutliqa11r');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483645, 997.73177, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 'par_da0e89', '8d99rljsl');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483644, 419.361606, 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', 'par_da0e89', 'vy9uxj4');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483643, 124.573829, 'd', 'lph2gn', 'q', 'nqcx5h', 'par_da0e89', 'cprj');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483642, 304.188492, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', 'par_533b04', '6vck6ah0f8js');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483641, 346.706184, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'par_533b04', 'ogrgjd8y');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483640, 763.019095, '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'par_533b04', 'c68x8vacx');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483639, 516.027628, 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 'par_da0e89', '0v');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483638, 492.883123, 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', 'par_da0e89', '0');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483637, 668.776683, 'z2zezjo7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'par_da0e89', 'pim5');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483636, 167.377262, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', NULL, 'e578');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483635, 944.379011, 'vy', '7zzbe8y', 'kv42q7', 'x58b4', NULL, 'pmaus3auvmkr');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483634, 641.973572, 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', NULL, 'do2zobb');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483633, 407.368744, '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', NULL, 'dt');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483632, 506.13059, 'uq', 'xuzkb52', 'gwnlas6', 'elboeowii1', NULL, '5nxih66');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483631, 441.511648, 'xlyotow9', 'aawg', '6aqb0tbin', 'z', NULL, '9tajz9td');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483630, 535.501742, '5wcgumbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', 'par_533b04', 'k162n');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483629, 111.965818, '5y3dohvu', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 'par_533b04', 'jaby');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483628, 607.620308, 'n2mfx7h', '3p6sto1c', '8sh', 'knzys7dy', 'par_533b04', 'yd1jmgjach8');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483627, 726.733068, 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 'par_da0e89', 'wlic7dn2');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483626, 828.220682, 'p490xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'par_da0e89', 'jq1');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483625, 256.829372, 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'par_da0e89', 'd8ftb8');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483624, 281.001583, '9114qbre6bj', 'uu', 'sj8kjh', '5wpxlvris', 'par_533b04', 'urz0kaqtncg');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483623, 599.871479, 's3b7v88kw', 'm', 'b', 'h', 'par_533b04', '6j47n');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483622, 370.459832, '50hsj', 'an', 'xdpunmw', 'wx', 'par_533b04', 'rlawk');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483621, 417.346356, '14r5dqtsmg97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'par_da0e89', 'r31');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483620, 332.858841, 'q51oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'par_da0e89', 'rpouit63xyf');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483619, 824.672918, 'jwpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'par_da0e89', 'l2i9');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483618, 72.185429, 'p', 'pgckqwtsr', '54o6qjektb1', '2', 'par_533b04', 'zg3r');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483617, 568.592974, 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', 'par_533b04', 'o');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483616, 445.910628, '7t3gvplj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'par_533b04', 'ez');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483615, 9.845649, 'c1clup', 'ly', '8oitxeilp', 'e019cy7od0', 'par_da0e89', '3dlhdsvn');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483614, 118.01298, '2', '9lqv26u331s', 'xpw3', 'bgwkxgi', 'par_da0e89', 'nlj6idmp61');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483613, 186.560838, 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'par_da0e89', 'kh');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483612, 699.840562, 'lbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'par_533b04', 'c296xiy');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483611, 812.879619, 't8', 'jhcf46', 'f', 'perxa61sjv', 'par_533b04', 'nv3ddroku');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483610, 70.620894, 'ctehia3', 'm', 'vb7vpc0xff', 'or1esk', 'par_533b04', 'f9q82');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483609, 255.938993, '1huij7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'par_da0e89', 'kwi3hl7j');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483608, 473.576214, '795ybv8', 'kr3w4jn2', '19xgjja', 'cgmukfb5if4', 'par_da0e89', '80terbf');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483607, 773.877369, 'vee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'par_da0e89', 'oqxs27xh');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attorney_general AS governor FROM (SELECT LHS.attorney_general AS attorney_general, LHS.n AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general)) AS RHS ON (LHS.n = RHS.n)) ORDER BY governor;

/*
Gold Result:
('par_533b04',)
('par_da0e89',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('m',)
*/