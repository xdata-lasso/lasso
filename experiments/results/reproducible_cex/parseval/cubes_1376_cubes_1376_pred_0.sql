-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (1, '5k5swwqcgs');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (-2147483648, '9n8', '4', 'gu7v');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (86.520366, 1, -2147483648, '4h', 'mat_470fee', -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (998.421621, 1, -2147483648, 'prmd', 'mat_470fee', -1137908826, 'siie5unw6k', 'fa9');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (627.258639, 1, -2147483648, '0t5c4ecigc', 'mat_470fee', 528680845, '76nium52', 'zbuo4nrqrof');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (586.906897, 1, -2147483648, 'bbp02eut', 'mat_470fee', -1347802441, 'a11ry', 'ytoo3o9hl7');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (389.878901, 1, -2147483648, 'lex', 'mat_470fee', 1775126557, 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (488.977171, 1, -2147483648, '9rljsl0b4', 'mat_470fee', 1649269347, 'p5qi2rkf9v', 'x58pz');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (694.765963, 1, -2147483648, '8jegd21vy9ux', NULL, -1492524358, 'wb', 'v');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (989.653112, 1, -2147483648, 'h2gndqwnqcx5', NULL, 580968159, 'cprj', 'u0dz7');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (154.065416, 1, -2147483648, '8n2f3', NULL, 806170397, 'qv0gcb98ozk', 'zbilyrkn');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (915.583344, 1, -2147483648, 'ah0f8jsww', 'mat_470fee', -1388029300, 'xb72fxa7r', 'fdrz16n');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (154.68882, 1, -2147483648, '5dh', 'mat_470fee', 1583472758, 'rg', 'd8y');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (639.801051, 1, -2147483648, 'f', 'mat_470fee', -1717646459, 'ri', 'tsj3ayxp1q4');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (787.642728, 1, -2147483648, 'jh3den8', 'mat_470fee', 195720193, 'vacx7afu5', '1of77p');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (224.624401, 1, -2147483648, '72ctdctmfg62', 'mat_470fee', -1744557630, '5q8qdj', 'e1io');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (445.968654, 1, -2147483648, '507cvtjpt', 'mat_470fee', 453836040, '6b', 'ou5z');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (464.719657, 1, -2147483648, '4', 'mat_470fee', -2072838897, 'foa', 'cd07z2zezjo7');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (108.948237, 1, -2147483648, 'd5ysxc', 'mat_470fee', -405743609, 'g', '5i3');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (264.110281, 1, -2147483648, '5lnpim5k58qs', 'mat_470fee', 1615073310, '7p2r94gth2m', 'ajjl');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (462.366429, 1, -2147483648, 'kv8u', 'mat_470fee', 618058035, '2ne578', 'fvy');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (823.908713, 1, -2147483648, 'zzbe8yvkv4', 'mat_470fee', -233617564, '7sx58b4pma', 'us3auvmkrpdj');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (401.500141, 1, -2147483648, '5chn9m', 'mat_470fee', 823835795, '05a9n0jxf', 'fwsz');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (969.175862, 1, -2147483648, '2zobb0q0k32o', 'mat_470fee', -1898678660, 'l', '5amsorlwyngc');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (48.973066, 1, -2147483648, '9er', 'mat_470fee', 1935791961, 'izgk1yoeyo6', 'l0hdt6fuqyx');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (908.792879, 1, -2147483648, 'b52', 'mat_470fee', -277407746, 'nlas6e', 'lboeowii1z5');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (627.816635, 1, -2147483648, 'h66', 'mat_470fee', -251205568, 'xlyotow9', 'aawg');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (725.010524, 1, -2147483648, '0', 'mat_470fee', -850941333, 'indz39tajz', 'td8n5wcgu');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (30.758515, 1, -2147483648, '3', 'mat_470fee', 1147652228, 'u', 'bd0w9603v');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (685.760212, 1, -2147483648, 'xw1rxe9yfk7q', 'mat_470fee', 312804300, '62nh55y3dohv', '06dza3');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (576.663277, 1, -2147483648, 'mkio1', 'mat_470fee', 769234989, '8ftp6ewtqx', 'njabym');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (615.054987, 1, -2147483648, 'n2mfx7h33p6s', 'mat_470fee', -843082635, 'cj8sh5k', 'zys7');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (376.265501, 1, -2147483648, 'd1jmgja', 'mat_470fee', -2008781089, 'qta8y3a17', 'v4ygmayq3qdp');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (871.372603, 1, -2147483648, '96rn', 'mat_470fee', 2013152515, 'q', 'hm5wl');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (45.731407, 1, -2147483648, 'dn2np490xdm', 'mat_470fee', 1996699977, 'tgelc', 'qb9i9f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT POSITION, team, COUNT(*) AS n FROM match_season GROUP BY POSITION, team) ORDER BY team DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('mat_470fee',)
*/