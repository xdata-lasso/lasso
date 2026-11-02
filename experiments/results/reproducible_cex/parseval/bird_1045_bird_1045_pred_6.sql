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
INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483648, 1, 'Franco Zennaro', -2147483648, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483647, 1, 'Franco Zennaro', -2147483647, 'pla_c01a5d', -664303813, -1022641847);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483646, 2, 'Franco Zennaro', -2147483646, 'pla_c01a5d', -2081315180, 1909986641);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483645, 2, 'Franco Zennaro', -2147483645, 'pla_c01a5d', 1485335077, -511185946);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483644, 2, 'Franco Zennaro', -2147483644, 'pla_c01a5d', 392822403, 2142703426);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483643, 2, 'Franco Zennaro', -2147483643, 'pla_c01a5d', -533293970, 176380444);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483642, 2, 'Franco Zennaro', -2147483642, 'pla_c01a5d', -977635379, 1661181156);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483641, 2, 'Franco Zennaro', -2147483641, 'pla_c01a5d', -1372125820, -2031361952);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (2, 1, 'Franco Zennaro', 2, 'pla_c01a5d', -1025564911, -227162283);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (3, 1, 'Franco Zennaro', 3, 'pla_c01a5d', 2056419640, 222415430);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483638, 1, 't1__0542ba', -2147483638, 'pla_c01a5d', -461695645, 836513442);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483637, 1, 't1__d80d17', -2147483637, 'pla_c01a5d', 176555546, -1937207087);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483636, 1, 'Franco Zennaro', -2147483636, 'pla_c01a5d', 233994589, 1442655647);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483635, 1, 'Franco Zennaro', -2147483635, 'pla_c01a5d', -87647544, -629784617);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (4, 1, 'pla_0d8e0d', -2147483634, 'pla_c01a5d', 1581736075, -261132974);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (6, 1, 'pla_0d8e0d', -2147483633, 'pla_c01a5d', -1264842910, -1052964641);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (5, 1, NULL, -2147483632, 'pla_c01a5d', 1371234901, -290314193);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (7, 1, 'Franco Zennaro', -2147483631, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (8, 1, 'Franco Zennaro', -2147483630, 'pla_c01a5d', 481163439, 2123196517);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (9, 1, 'Franco Zennaro', -2147483629, 'pla_c01a5d', -515895469, 1427161052);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (10, 1, 'Franco Zennaro', -2147483628, 'pla_c01a5d', -15162884, 1339733032);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (11, 1, 'Franco Zennaro', -2147483627, 'pla_c01a5d', 1483450542, 513375398);

-- Inserting into table: player_attributes --
INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (2, -2147483648, 1, 'pla_49697d', -890215420, 1610062532, 'pla_214929', 't2__2f8475', 'pla_29e652', -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, 1419861592);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (3, -2147483647, 1, 'pla_49697d', 374105386, 1274489983, 'pla_214929', 't2__2f8475', 'pla_29e652', -1683203397, 528680845, -1585009206, -53231346, -443340271, 757448742, -1179823637, 1119186446, 781505063, 418417917, -1031969798, -1106983592, 1884179925, 902551284, 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (5, -2147483642, 1, 'pla_49697d', -1070063173, 555413010, 'pla_214929', 'pla_924593', 'pla_29e652', 722884590, 580968159, -1245312912, 1575412235, -988981234, -841004020, -361507387, 401805964, -1485777725, -1255130038, -1762857309, 806170397, 513454646, -688216274, 331812443, 1382410067, 1631231566, 172461907, 1606439408, 1443629118, -155284187, 1686459626, -1554531873, 982314585, 638024588, -688098735, 1784916884, 37673509, 834709651, -348113485, 138842628, -932772113, -639539893);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (7, 2, 1, 'pla_49697d', -566887085, 602161869, 'pla_214929', 'pla_924593', 'pla_29e652', 1350414441, 2094425101, -961217731, -1888505890, 777149609, 61479715, -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 678047687, -1478134144, -491938169, -106471771, 1235416111, 1923912467, 518609210, 1948383687, 1476361420, 195720193, 1774087382, 1732258051, -1762140823);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (4, -2147483646, 1, 'pla_49697d', -1099855564, 87529806, 'pla_214929', 'pla_924593', 'pla_29e652', -1957268147, -1928431425, 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 820970595, 1421303999, -1488156735, -1858644047, -1180042408, 199672698, 2119806856, -1962347906, -866772222, -847293924, -2033879835, 1798111945, 944975670, -1575410149, -68044929, -1776877925, 1201273976, 1923659053, -1950324754, 2115816682, 76987628, -253138337, 641521863, 304189298, -542502665, 1999335832);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483643, -2147483637, 1258409369, 'pla_49697d', -1981402255, -890215420, 'pla_214929', NULL, 'pla_29e652', 1610062532, -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 1038707349);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (6, -2147483631, 1, 'pla_49697d', 1620389964, 546571701, 'pla_214929', 'pla_924593', 'pla_29e652', 947159877, 1990080517, 1408123494, -1964997180, 1149850321, -1833165707, 1155439218, 1313172851, -761141909, 283598170, 742285925, -747753377, 902887186, -967741825, 775304493, 373262291, -472966518, -921187550, -2070843029, 328305758, -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 274769912, -188151580, 226938182, 90119032, -1438850342, -305670381, -1525670226, -453362185);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483641, -2147483647, 1485335077, 'pla_49697d', -511185946, -1021749117, 'pla_214929', NULL, 'pla_29e652', 392822403, 2142703426, -533293970, 176380444, -977635379, 1661181156, -1372125820, -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, -975213201, -705985602, 537874887, -461695645, 836513442, 176555546, -1937207087, 1675430660, -688509700, -792092619, -1492524358, -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 1298861365, 1968874827, -664193365, -1070063173, 555413010);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (8, -2147483633, 1, 'pla_49697d', 580968159, -1245312912, 'pla_214929', 'pla_924593', 'pla_29e652', 1575412235, -988981234, -841004020, -361507387, 401805964, -1485777725, -1255130038, -1762857309, 806170397, 513454646, -688216274, 331812443, 1382410067, 1631231566, 172461907, 1606439408, 1443629118, -155284187, 1686459626, -1554531873, 982314585, 638024588, -688098735, 1784916884, 37673509, 834709651, -348113485, 138842628, -932772113, -639539893, 1255343543, -541746689, 1294666887);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483639, 2, 777149609, 'pla_49697d', 61479715, -1496556994, 'pla_214929', NULL, 'pla_29e652', -2115841792, 1746373317, 1360271423, 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 678047687, -1478134144, -491938169, -106471771, 1235416111, 1923912467, 518609210, 1948383687, 1476361420, 195720193, 1774087382, 1732258051, -1762140823, 1371234901, -290314193, 76996700, -435350511, 1992637800, -820614248, 481546706);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (9, -2147483646, 1, 'pla_49697d', 7929158, -1744557630, 'pla_214929', 'pla_924593', 'pla_29e652', 1870300798, 820970595, 1421303999, -1488156735, -1858644047, -1180042408, 199672698, 2119806856, -1962347906, -866772222, -847293924, -2033879835, 1798111945, 944975670, -1575410149, -68044929, -1776877925, 1201273976, 1923659053, -1950324754, 2115816682, 76987628, -253138337, 641521863, 304189298, -542502665, 1999335832, -526612570, -546516406, -405743609, -1935752926, -20116244, -176606723);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483637, -2147483641, 1692046802, 'pla_49697d', -1300180872, -1125548818, 'pla_214929', NULL, 'pla_29e652', 1497321728, -95808609, -244633520, 418247369, -1524425594, -1351793914, 1919033056, -1428186898, -761353513, 362376128, -1311735207, -229022515, -1817527403, -1402164108, 2123471885, -526633767, 448935289, 458835042, 924693315, -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (10, -2147483630, 1, 'pla_49697d', -1140595602, -609553675, 'pla_214929', 'pla_924593', 'pla_29e652', 989018473, -55494714, -1674145149, 234957614, 823835795, -354292049, 238533676, -1514700303, -1796351243, -1793230843, -441521858, 2015094998, 1010672881, -1197954156, -2019656607, 375841374, -1449226553, -225238282, -1898678660, 440115543, 292557306, 709097796, -984562992, -605061107, -1689155697, -323362455, 453340472, 211603887, -413043724, 761519897, 1504707292, 955267863, -1156828895);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483635, -2147483632, -360096930, 'pla_49697d', -1942581013, -795975227, 'pla_214929', NULL, 'pla_29e652', 1294064538, 778835680, 1755752040, 1262491793, 450555855, -206528034, -1686002788, -1250380401, 1718516876, -2076274980, 1731324803, -1159083009, -1589605308, -268740517, -564679000, -251205568, 287256667, 1614799674, 1083479253, 1774679448, 205676091, -2094843966, -1048779857, -381485009, 868039568, 503053726, -1897615568, 2085299664, 2038321753, 1376887048, 261633665, 748154000, 1148916014);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (11, -2147483647, 1, 'pla_49697d', -1694533100, -1275298282, 'pla_214929', 'pla_924593', 'pla_29e652', 1933158443, 1295379066, 1071401016, 40558455, 740386991, 2018368241, 920097188, -639616320, 1689143863, 237552112, -1046720861, 643589729, -1231488097, 956819642, 774922170, 2105860871, -141591627, 440797047, -732999244, 1654100852, 30861410, -438741674, -154207334, 729449685, -1580984044, 150596046, 431832073, 1510892261, 1677948887, 389700824, -1853955201, -805997097, -586285368);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT t2.attacking_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Franco Zennaro';

/*
Gold Result:
('pla_924593',)
('t2__2f8475',)
*/

-- Prediction Query
SELECT Player_Attributes.attacking_work_rate FROM Player INNER JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player.player_name = 'Franco Zennaro';

/*
Prediction Result:
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('pla_924593',)
('t2__2f8475',)
('t2__2f8475',)
*/