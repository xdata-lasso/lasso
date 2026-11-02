-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (-2147483648, '9n8', '4', 'gu7v');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (86.520366, -2147483648, -2147483648, '4h', 'ia2yp', -1670923962, 'rwbbp6luhvd', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (304.02808, -2147483648, -2147483648, 'bnp', 'mdpos', -1576219117, '5u', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (992.733505, -2147483648, -2147483648, 'lfa', '9000t5c4ec', -1683203397, 'e376nium52', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (676.357279, -2147483648, -2147483648, '4nrq', 'rofqyp5s5b', 2107872094, '02eutliqa11r', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (300.875654, -2147483648, -2147483648, 'oo3o9hl72kle', 'x14ji7zwau2d', 1485335077, 'yrq13pyu78d9', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (145.402595, -2147483648, -2147483648, 'l0b4y', 'p5qi2rkf9v', 556727997, '8pz0f8je', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (452.27611, -2147483648, -2147483648, 'vy9uxj4', 'wb', -1929953647, 'ph2', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (58.749749, -2147483648, -2147483648, 'wnqcx', '5hncprjtu0d', 401805964, 'gq8', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (89.552801, -2147483648, -2147483648, 'dqv0gcb98ozk', 'zbilyrkn', -688098735, '6ah', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (532.326819, -2147483648, -2147483648, 'wwlq7', 'xb72fxa7ryfd', 564390026, '6nijjai5dh', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (837.437794, -2147483648, -2147483648, 'gjd8y', 't1afgog', -946046410, 'tsj3ayxp1q4', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (947.945777, -2147483648, -2147483648, 'jh3den8c68', '8vacx7', 1523825314, 'u5', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (222.511261, -2147483648, -2147483648, 'f77pzo72ctd', 't', -1284905200, '62', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (935.463334, -2147483648, -2147483648, 'q8qdjpe1', 'o22', 2004147439, 'tjpttg', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (918.655561, -2147483648, -2147483648, '5zi36c', 'bfkfoacd', 2115816682, '7z2zezjo7wg', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (965.506647, -2147483648, -2147483648, 'sxcmr0o', 'ztdgj5i3lq5l', 1339733032, 'im5k', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (975.929586, -2147483648, -2147483648, '27p2r', '4gth2mnaj', -1478011227, '3', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (338.437591, -2147483648, -2147483648, 'uttmu2ne578', 'fvy', -451030047, 'be8yvkv42q7', NULL);

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (927.310086, -2147483648, -2147483648, '58b4pmaus3a', 'vmkrpd', -609553675, 'w5chn9mo705a', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (903.226183, -2147483648, -2147483648, 'fofwsz', 'o', 1010672881, 'obb0q0k', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (229.650617, -2147483648, -2147483648, 'cl5ams', 'orlwyngc1dj', 211603887, 'rhizgk1yoey', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (832.527521, -2147483648, -2147483648, 'dt', 'fuqyxuzkb', -30041412, 'gwnlas6', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (744.040787, -2147483648, -2147483648, 'eowi', '1z5', 1557188093, 'xih662q2xly', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (646.67543, -2147483648, -2147483648, 'w9oa', 'awg96aqb0tbi', 503053726, 'z', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (974.58376, -2147483648, -2147483648, 'z9t', '8', 748154000, 'cgumbc', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (821.043976, -2147483648, -2147483648, 'u6bd0w9603', 'vzxw1rxe9y', -1046720861, '162nh55y3d', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (898.062947, -2147483648, -2147483648, '06dza3', 'rmkio18r', 431832073, 'hy08ftp6', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (312.339174, -2147483648, -2147483648, 'xnjaby', 'mzn2mfx7h3', -891525031, '1cj8', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (485.281618, -2147483648, -2147483648, 'zys7', 'y', -531932574, 'jmgjach', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (644.437797, -2147483648, -2147483648, '8y3a17v4yg', 'mayq3qdpua', 1291298007, 'tdqr', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (487.287849, -2147483648, -2147483648, 'wlic7dn2np', '90xdmsqt', -1685482179, 'cuq', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (555.47049, -2147483648, -2147483648, 'ccukjq1q', 'ik1yhb', 1862728578, 't1pqomiztvb6', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (137.186478, -2147483648, -2147483648, '78aqqlud8ft', '8', 1183069552, '4qbre6b', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (584.815773, -2147483648, -2147483648, 'wsj8kj', '85', -609840352, 'lvrisu', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (409.538993, -2147483648, -2147483648, 'q', 'ncgc8', 1446366856, 'b7v88kwd', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (889.074497, -2147483648, -2147483648, 'h', '6j47n', -556370776, '50hsj', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (210.413164, -2147483648, -2147483648, 'xdpunmw', 'wx', -1040088060, 'awk', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (471.914793, -2147483648, -2147483648, 'dqtsmg97', 'aqz2o20pj6d', 1928920679, 'ysu', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (112.467274, -2147483648, -2147483648, 'u2g', 'r31', -717865822, 'q51oa2sb3u', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (422.16262, -2147483648, -2147483648, 'avcv', 'wnyqrouirlrp', 1026055008, 'it63xy', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (189.105795, -2147483648, -2147483648, 'wpp26mb3aj0j', '0h3r13', -156860347, 'r1axyyhpl2i', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (13.527735, -2147483648, -2147483648, '8pgc', 'qwt', 1339281953, '4o6qjektb1', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (211.896872, -2147483648, -2147483648, 'g3rjkwn', '47j2j', -1881008758, 'y', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (610.035242, -2147483648, -2147483648, 'wq49yrnxs6d', 'dxdo2v', 1805923837, 'plj9fj', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (320.846982, -2147483648, -2147483648, '7k10', 'z2my1ogyv1r', -1712532464, 'axc1clu', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (707.803422, -2147483648, -2147483648, 'y78oitxeilp', 'e019cy7od0', -1882121644, 'hdsvnhed29lq', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (954.744224, -2147483648, -2147483648, 'u331spxpw30b', 'wk', 1659285381, 'in', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (563.529532, -2147483648, -2147483648, 'dmp', '1l2o3ak16', 1562909425, 'cagj', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (599.215572, -2147483648, -2147483648, 'xzxlu4', 'kuboe8cde', 1557266002, 'ekhllb', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (58.4493, -2147483648, -2147483648, '5v0edu', 'y9v2z12983', 1870044139, 'oepacx', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (448.700958, -2147483648, -2147483648, 'c296xiy', 'et8xjhcf46c', 312333412, 'erxa61sjv8nv', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (59.584068, -2147483648, -2147483648, 'kuez', 'ctehia3cmvb', -1077762203, 'xffwor1', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (978.77393, -2147483648, -2147483648, 'f9q82', 'g01hu', -1585280787, '7f8kqhiu5g', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (366.943962, -2147483648, -2147483648, '5', 'qjlsawsp4kw', -1581061582, 'l7', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (455.92055, -2147483648, -2147483648, '795ybv83kr3', 'w4jn2z19xgj', 319828561, 'c', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (320.34146, -2147483648, -2147483648, 'fb5', 'f41', -813616969, 'bfokv', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (513.813043, -2147483648, -2147483648, 'tut', '6lu2cel8mh', -1957884289, 'n5en', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (962.255615, -2147483648, -2147483648, 'mb', 'z5', 1778447090, 's27xh8', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (159.703774, -2147483648, -2147483648, '53sb59ls', '1ehn1mdaqq', 1306095601, 'yyzsnp64hm', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (345.351353, -2147483648, -2147483648, '4m0rrwbjk0', 'p', 1851648795, 'w', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (146.24274, -2147483648, -2147483648, 'lwtlzh42nyj5', 'rji5mqk', 1192169191, '8gfxswb2d0zm', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (49.061305, -2147483648, -2147483648, '7', 'tp5q', -1147699861, '4c6', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (207.246012, -2147483648, -2147483648, 'kd4kc3iikaxz', '90nhs', -1205570400, '6', 'mat_e105dc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (212.283935, -2147483648, -2147483648, 'jphybn', 'a', -534612951, 'hvyx8scr0fs3', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (415.172857, -2147483648, -2147483648, '5', '2rlx', 1741116512, 'wfx03', 'mat_096dce');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (795.50586, -2147483648, -2147483648, '84lqme2', 'wb1b3vun66e0', -1576807806, 'olt070zi90o5', 'mat_096dce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT college_other AS college FROM (SELECT LHS.college AS college, LHS.n AS n, RHS.college AS college_other, RHS.n AS n_other FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS LHS CROSS JOIN (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS RHS) WHERE (n < n_other) ORDER BY college;

/*
Gold Result:
('mat_096dce',)
('mat_e105dc',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 3;

/*
Prediction Result:
('mat_096dce',)
('mat_e105dc',)
(None,)
*/