-- Schema DDL
CREATE TABLE IF NOT EXISTS "Player_Attributes" ("id" INTEGER PRIMARY KEY, "player_fifa_api_id" INTEGER, "player_api_id" INTEGER, "date" TEXT(255), "overall_rating" INTEGER, "potential" INTEGER, "preferred_foot" TEXT(255), "attacking_work_rate" TEXT(255), "defensive_work_rate" TEXT(255), "crossing" INTEGER, "finishing" INTEGER, "heading_accuracy" INTEGER, "short_passing" INTEGER, "volleys" INTEGER, "dribbling" INTEGER, "curve" INTEGER, "free_kick_accuracy" INTEGER, "long_passing" INTEGER, "ball_control" INTEGER, "acceleration" INTEGER, "sprint_speed" INTEGER, "agility" INTEGER, "reactions" INTEGER, "balance" INTEGER, "shot_power" INTEGER, "jumping" INTEGER, "stamina" INTEGER, "strength" INTEGER, "long_shots" INTEGER, "aggression" INTEGER, "interceptions" INTEGER, "positioning" INTEGER, "vision" INTEGER, "penalties" INTEGER, "marking" INTEGER, "standing_tackle" INTEGER, "sliding_tackle" INTEGER, "gk_diving" INTEGER, "gk_handling" INTEGER, "gk_kicking" INTEGER, "gk_positioning" INTEGER, "gk_reflexes" INTEGER, FOREIGN KEY (player_fifa_api_id) REFERENCES Player (player_fifa_api_id));

CREATE TABLE IF NOT EXISTS "Player" ("id" INTEGER PRIMARY KEY, "player_api_id" INTEGER, "player_name" TEXT(255), "player_fifa_api_id" INTEGER UNIQUE, "birthday" TEXT(255), "height" INTEGER, "weight" INTEGER);

CREATE TABLE IF NOT EXISTS "League" ("id" INTEGER PRIMARY KEY, "country_id" INTEGER, "name" TEXT(255), FOREIGN KEY (country_id) REFERENCES Country (id));

CREATE TABLE IF NOT EXISTS "Country" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE IF NOT EXISTS "Team" ("id" INTEGER PRIMARY KEY, "team_api_id" INTEGER UNIQUE, "team_fifa_api_id" INTEGER UNIQUE, "team_long_name" TEXT(255), "team_short_name" TEXT(255));

CREATE TABLE IF NOT EXISTS "Team_Attributes" ("id" INTEGER PRIMARY KEY, "team_fifa_api_id" INTEGER, "team_api_id" INTEGER, "date" TEXT(255), "buildUpPlaySpeed" INTEGER, "buildUpPlaySpeedClass" TEXT(255), "buildUpPlayDribbling" INTEGER, "buildUpPlayDribblingClass" TEXT(255), "buildUpPlayPassing" INTEGER, "buildUpPlayPassingClass" TEXT(255), "buildUpPlayPositioningClass" TEXT(255), "chanceCreationPassing" INTEGER, "chanceCreationPassingClass" TEXT(255), "chanceCreationCrossing" INTEGER, "chanceCreationCrossingClass" TEXT(255), "chanceCreationShooting" INTEGER, "chanceCreationShootingClass" TEXT(255), "chanceCreationPositioningClass" TEXT(255), "defencePressure" INTEGER, "defencePressureClass" TEXT(255), "defenceAggression" INTEGER, "defenceAggressionClass" TEXT(255), "defenceTeamWidth" INTEGER, "defenceTeamWidthClass" TEXT(255), "defenceDefenderLineClass" TEXT(255), FOREIGN KEY (team_fifa_api_id) REFERENCES Team (team_fifa_api_id));

CREATE TABLE IF NOT EXISTS "Match" ("id" INTEGER PRIMARY KEY, "country_id" INTEGER, "league_id" INTEGER, "season" TEXT(255), "stage" INTEGER, "date" TEXT(255), "match_api_id" INTEGER, "home_team_api_id" INTEGER, "away_team_api_id" INTEGER, "home_team_goal" INTEGER, "away_team_goal" INTEGER, "home_player_X1" INTEGER, "home_player_X2" INTEGER, "home_player_X3" INTEGER, "home_player_X4" INTEGER, "home_player_X5" INTEGER, "home_player_X6" INTEGER, "home_player_X7" INTEGER, "home_player_X8" INTEGER, "home_player_X9" INTEGER, "home_player_X10" INTEGER, "home_player_X11" INTEGER, "away_player_X1" INTEGER, "away_player_X2" INTEGER, "away_player_X3" INTEGER, "away_player_X4" INTEGER, "away_player_X5" INTEGER, "away_player_X6" INTEGER, "away_player_X7" INTEGER, "away_player_X8" INTEGER, "away_player_X9" INTEGER, "away_player_X10" INTEGER, "away_player_X11" INTEGER, "home_player_Y1" INTEGER, "home_player_Y2" INTEGER, "home_player_Y3" INTEGER, "home_player_Y4" INTEGER, "home_player_Y5" INTEGER, "home_player_Y6" INTEGER, "home_player_Y7" INTEGER, "home_player_Y8" INTEGER, "home_player_Y9" INTEGER, "home_player_Y10" INTEGER, "home_player_Y11" INTEGER, "away_player_Y1" INTEGER, "away_player_Y2" INTEGER, "away_player_Y3" INTEGER, "away_player_Y4" INTEGER, "away_player_Y5" INTEGER, "away_player_Y6" INTEGER, "away_player_Y7" INTEGER, "away_player_Y8" INTEGER, "away_player_Y9" INTEGER, "away_player_Y10" INTEGER, "away_player_Y11" INTEGER, "home_player_1" INTEGER, "home_player_2" INTEGER, "home_player_3" INTEGER, "home_player_4" INTEGER, "home_player_5" INTEGER, "home_player_6" INTEGER, "home_player_7" INTEGER, "home_player_8" INTEGER, "home_player_9" INTEGER, "home_player_10" INTEGER, "home_player_11" INTEGER, "away_player_1" INTEGER, "away_player_2" INTEGER, "away_player_3" INTEGER, "away_player_4" INTEGER, "away_player_5" INTEGER, "away_player_6" INTEGER, "away_player_7" INTEGER, "away_player_8" INTEGER, "away_player_9" INTEGER, "away_player_10" INTEGER, "away_player_11" INTEGER, "goal" TEXT(255), "shoton" TEXT(255), "shotoff" TEXT(255), "foulcommit" TEXT(255), "card" TEXT(255), "cross" TEXT(255), "corner" TEXT(255), "possession" TEXT(255), "B365H" REAL, "B365D" REAL, "B365A" REAL, "BWH" REAL, "BWD" REAL, "BWA" REAL, "IWH" REAL, "IWD" REAL, "IWA" REAL, "LBH" REAL, "LBD" REAL, "LBA" REAL, "PSH" REAL, "PSD" REAL, "PSA" REAL, "WHH" REAL, "WHD" REAL, "WHA" REAL, "SJH" REAL, "SJD" REAL, "SJA" REAL, "VCH" REAL, "VCD" REAL, "VCA" REAL, "GBH" REAL, "GBD" REAL, "GBA" REAL, "BSH" REAL, "BSD" REAL, "BSA" REAL, FOREIGN KEY (home_team_api_id) REFERENCES Team (team_api_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: player --
INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483648, 1, 'Francesco Migliore', -2147483648, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483647, 1, 'Francesco Migliore', -2147483647, 'pla_c01a5d', 1038707349, 1419861592);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483646, 1, 'Francesco Migliore', -2147483646, 'pla_c01a5d', 700088193, 374105386);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483645, 2, 'Francesco Migliore', -2147483645, 'pla_c01a5d', -1748371085, -1742081330);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483644, 2, 'Francesco Migliore', -2147483644, 'pla_c01a5d', -491938169, -106471771);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483643, 2, 'Francesco Migliore', -2147483643, 'pla_c01a5d', -2072838897, -1173368267);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (2, 1, 'Francesco Migliore', 2, 'pla_c01a5d', -1252009958, 1908593332);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (3, 1, 'Francesco Migliore', 3, 'pla_c01a5d', 697257217, -451030047);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483640, 1, 'Francesco Migliore', -2147483640, 'pla_c01a5d', -2121397544, 1595632888);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483639, 1, 't1__a27b10', -2147483639, 'pla_c01a5d', 339193890, -493230039);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483638, 1, 'Francesco Migliore', -2147483638, 'pla_c01a5d', 44959255, -74691962);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (4, 1, 'pla_0d8e0d', -2147483637, 'pla_c01a5d', 1463445550, -1096060187);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (6, 1, 'pla_0d8e0d', -2147483636, 'pla_c01a5d', 2014610660, 1492264835);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (5, 1, NULL, -2147483635, 'pla_c01a5d', 987928936, -1042838119);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (7, 1, 'Francesco Migliore', -2147483634, 'pla_c01a5d', -333485269, -1712532464);

-- Inserting into table: player_attributes --
INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483648, -2147483648, 1, '2015-05-01', 1258409369, -1981402255, 'pla_214929', 't2__5e6558', 'pla_29e652', -890215420, 1610062532, -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (2, -2147483646, 1, '2015-05-01', 1274489983, -1683203397, 'pla_214929', 't2__5e6558', 'pla_29e652', 528680845, -1585009206, -53231346, -443340271, 757448742, -1179823637, 1119186446, 781505063, 418417917, -1031969798, -1106983592, 1884179925, 902551284, 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (3, -2147483646, 1, '2015-05-01', 2123196517, 364869063, 'pla_214929', 't2__5e6558', 'pla_29e652', -953437896, -1097120355, 244829661, -1362461264, -904834265, -346339240, 1692174491, -1025564911, -227162283, 2056419640, 222415430, 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 910894705, -283454505, 233994589, 1442655647, -87647544, -629784617, -1929953647, 1581736075, -261132974, -1264842910, -1052964641, -1245682094, -1660358170, -1106350634, -1509264256, -792947627, -1898531797);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483645, -2147483647, 3, '2015-05-01', -211209314, -1056308489, 'pla_214929', 't2__5e6558', 'pla_29e652', -1454058168, -2078052421, -512640349, 1038566008, 32204797, -1672720816, -1520489792, -658391922, -1388029300, -566887085, 602161869, 1350414441, 2094425101, -961217731, -1888505890, 777149609, 61479715, -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 678047687, -1478134144);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483644, -2147483645, 3, '2015-05-01', 1923912467, 518609210, 'pla_214929', 't2__5e6558', 'pla_29e652', 1948383687, 1476361420, 195720193, 1774087382, 1732258051, -1762140823, 1371234901, -290314193, 76996700, -435350511, 1992637800, -820614248, 481546706, -1784554553, -242584410, -698610044, -1021978385, 569007824, -1139855872, -288338724, 1897687032, -241848752, 2004147439, -691774480, -1523347137, 1582582341, 453836040, 1467355421, -1171104889, -29242208, 1691780814, 1944978593, 1722106924);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483643, -2147483643, 3, '2015-05-01', -1950324754, 2115816682, 'pla_214929', 't2__5e6558', 'pla_29e652', 76987628, -253138337, 641521863, 304189298, -542502665, 1999335832, -526612570, -546516406, -405743609, -1935752926, -20116244, -176606723, -15162884, 1339733032, -1556979799, -55240145, 1379859112, 195202164, 1817366143, 1615073310, 1055237066, 988954859, -1719383707, 1273687251, 333302050, 1162591638, -2136247961, -1478011227, -2096405521, 1803796945, 872694102, 618058035, 1553368934);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483642, -2147483648, 1, '2015-05-01', 924693315, -705922211, 'pla_214929', 't2__5e6558', 'pla_29e652', 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274, -1140595602, -609553675, 989018473, -55494714, -1674145149, 234957614, 823835795, -354292049, 238533676, -1514700303, -1796351243, -1793230843, -441521858, 2015094998, 1010672881, -1197954156, -2019656607, 375841374, -1449226553, -225238282);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483641, -2147483648, 1, '2015-05-01', -613916489, 2061558815, 'pla_214929', 't2__5e6558', 'pla_29e652', 895277769, 364043263, -1177989415, -1352968577, -519515742, 1953495465, -1960313034, 681061317, 1935791961, 595714424, 1056589776, -499913447, -360096930, -1942581013, -795975227, 1294064538, 778835680, 1755752040, 1262491793, 450555855, -206528034, -1686002788, -1250380401, 1718516876, -2076274980, 1731324803, -1159083009, -1589605308, -268740517, -564679000, -251205568, 287256667, 1614799674);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483640, -2147483645, 1, '2015-05-01', 1774679448, 205676091, 'pla_214929', 't2__5e6558', 'pla_29e652', -2094843966, -1048779857, -381485009, 868039568, 503053726, -1897615568, 2085299664, 2038321753, 1376887048, 261633665, 748154000, 1148916014, -1988582944, -794767771, 989306270, 1147652228, 1378873397, 1964331395, -1943814113, 1514371324, -379749892, -541917667, -961629819, 2012400150, -505019168, 1968783602, 125495479, 312804300, -246257698, -516345261, -1191116453, 1709667347, -1934709172);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483639, -2147483645, 1, '@S??R?72(_tS?D', -1580984044, 150596046, 'pla_214929', 't2__5e6558', 'pla_29e652', 431832073, 1510892261, 1677948887, 389700824, -1853955201, -805997097, -586285368, 1664452437, -1485875026, -2080232972, 462225708, 1528227252, -1277305894, -1659775598, -891525031, -1154091048, -1971560508, 1728926031, -63214972, 1106724223, 1966809332, 1487347213, 1328948152, -1923069176, -1520090613, 591870819, 729543907, -2108844113, 973811121, 280292620, 620355627, -531872415, -2125172723);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483638, -2147483639, 1, '2015-05-01', -2081662466, -1941472821, 'pla_214929', 't2__5e6558', 'pla_29e652', -2082238979, -845136979, -1042976410, -1670945624, 555368535, -1369148652, 899787662, 594760660, 833568923, -384749431, -934098178, -827883679, -1872934808, -1974774786, 422046500, -1750715330, 277649518, 908468929, 1149620614, -1414362698, 1046248997, 1584429327, -1575692857, 1570917601, 775289854, -2052350430, 166124233, 1862197286, 1040753276, -324012243, -1333785554, 1784997708, -696672546);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483637, 2, 1, '2015-05-01', 195316816, 1728201214, 'pla_214929', NULL, 'pla_29e652', -1370566258, 948460309, 1183069552, -1057355067, -1004098188, 316163741, -752650834, 2134937984, 1379644459, 136003842, -1486030107, 1138926079, -609840352, 486475144, -679850352, 1205111943, -459075802, -1472584267, 1384307628, 1388796595, -881085433, 1501227157, -1462262193, -2070247503, -1629148699, 103252327, -556370776, 1144507576, -343920305, 460471995, -1515201134, -2121944911, 1195320303);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (5, -2147483643, 1, 'pla_49697d', -544173163, -958321297, 'pla_214929', 'pla_924593', 'pla_29e652', 2015039199, -641927001, 558684943, -120625031, 572453185, 1348973408, -911953404, 1084127083, -1019350771, -225571092, -261782899, -1079009577, -1385967617, 1813965704, 719861381, 1193656937, 434520825, -1664440372, 1849928338, 1113005977, -176968915, -717865822, 2061102304, -1204806277, 1813968674, 1907670428, 1265709623, 1731005516, 1388661799, -1574319760, 473443538, 1754053934, 1206923461);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (7, -2147483643, 1, 'pla_49697d', 2095277250, 1971816668, 'pla_214929', 'pla_924593', 'pla_29e652', -1067465394, 1491006943, -980625770, 721232773, 323781506, 1026055008, -1599077491, 1589523321, 586437419, -711121679, 1977502251, -1094296226, 1913338832, -2061050846, 1893953818, -364462246, 982289268, 493701528, 461842658, -156860347, 1805058154, -270436559, -569461411, 1498496406, 370054768, -1837449583, 1299933788, 679285124, 1752727653, 1394285393, -1052659852, 1092207544, 851545765);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (4, -2147483647, 1, '2015-05-01', 889799750, -860028884, 'pla_214929', 'pla_924593', 'pla_29e652', 328574939, 1464469520, -209435372, 946571403, -1517965246, 1807244612, 1125564712, -233564324, -1881008758, -1955129162, -1015337060, 403107330, 1497187692, 1511946366, -1910754958, -1900450199, -232312083, 1805923837, -699779308, -1368221491, 231250827, -1519752081, 906349223, 1200703349, 108903912, -307050678, 720126052, 629588446, 973615628, 1883146395, 2050088460, 699455208, -489473841);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (6, 2, 1, NULL, -560601844, 541973266, 'pla_214929', 'pla_924593', 'pla_29e652', -1970162044, 324939521, -1131290294, 892508923, 653399300, 139907579, 914471233, -1813651479, -1353862813, -1839279753, -1958403507, 72217086, -392891099, 1529023742, 1735624376, -1665891229, -929713613, -1239290359, -1832294694, 1188203659, -1066046077, 972991637, 1032462616, 980224846, -169055351, -894726713, -1089715864, -165171643, -2051120765, -607931326, 1659285381, 1693638235, 1718551923);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t2.attacking_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTRING(t2."date", 1, 10) = '2015-05-01' AND t1.player_name = 'Francesco Migliore';

/*
Gold Result:
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('pla_924593',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
*/

-- Prediction Query
SELECT T2.attacking_work_rate FROM Player AS T1 INNER JOIN Player_Attributes AS T2 ON T1.player_fifa_api_id = T2.player_fifa_api_id WHERE T1.player_name = 'Francesco Migliore' AND T2.date LIKE '2015-05-01%';

/*
Prediction Result:
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
('t2__5e6558',)
(None,)
('t2__5e6558',)
('t2__5e6558',)
('pla_924593',)
*/