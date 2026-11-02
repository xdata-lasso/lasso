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
INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483648, 1, 'Alexis Blin', -2147483648, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483647, 1, 'Alexis Blin', -2147483647, 'pla_c01a5d', -664303813, -1022641847);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483646, 1, 'Alexis Blin', -2147483646, 'pla_c01a5d', -1438850342, -305670381);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483645, 1, 'Alexis Blin', -2147483645, 'pla_c01a5d', 2103044118, -1642259219);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483644, 1, 'Alexis Blin', -2147483644, 'pla_c01a5d', 1746373317, 1360271423);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483643, 1, 'Alexis Blin', -2147483643, 'pla_c01a5d', 7929158, -1744557630);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483642, 1, 'Alexis Blin', -2147483642, 'pla_c01a5d', -15162884, 1339733032);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483641, 1, 'Alexis Blin', -2147483641, 'pla_c01a5d', 1164790775, -200807520);

-- Inserting into table: player_attributes --
INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (2, -2147483648, 1, 'pla_49697d', -890215420, 1610062532, 'pla_214929', 'pla_924593', 'pla_29e652', -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 1, 1, 1, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (3, -2147483648, 1, 'pla_49697d', 1151980946, 1620389964, 'pla_214929', 'pla_924593', 'pla_29e652', 546571701, 947159877, 1990080517, 1408123494, -1964997180, 1149850321, -1833165707, 1155439218, 1313172851, -761141909, 1, 1, 1, 283598170, 742285925, -747753377, 902887186, -967741825, 775304493, 373262291, -472966518, -921187550, -2070843029, 328305758, -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 274769912, -188151580, 226938182, 90119032);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483646, -2147483648, 1, 'pla_49697d', 105869088, -2081315180, 'pla_214929', 'pla_924593', 'pla_29e652', 1909986641, 1485335077, -511185946, -1021749117, 392822403, 2142703426, -533293970, 176380444, -977635379, 1661181156, 1, 1, 1, -1372125820, -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, -975213201, -705985602, 537874887, -461695645, 836513442, 176555546, -1937207087, 1675430660, -688509700, -792092619, -1492524358, -1612443122, -2050247126, -736979194);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483645, -2147483648, 1, 'pla_49697d', -1264842910, -1052964641, 'pla_214929', 'pla_924593', 'pla_29e652', -1245682094, -1660358170, -1106350634, -1509264256, -792947627, -1898531797, -1748371085, -1742081330, 894242932, -211209314, 1, NULL, 1, -1056308489, -1454058168, -2078052421, -512640349, 1038566008, 32204797, -1672720816, -1520489792, -658391922, -1388029300, -566887085, 602161869, 1350414441, 2094425101, -961217731, -1888505890, 777149609, 61479715, -1496556994, -2115841792);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483644, -2147483645, 1, 'pla_49697d', -1738458256, -1714354341, 'pla_214929', 'pla_924593', 'pla_29e652', -458359144, 600440952, 1568069663, -1794176801, -1194675273, -946046410, -902895762, -197933860, 2111987706, -598313376, 1, 1, NULL, 1972233925, 1792827279, 804529642, -1538707438, -163600466, -1826414375, 357330522, -683007527, 2035306060, 1523825314, 2078438287, -47052816, 645287482, 765724008, -1099855564, 87529806, -1957268147, -1928431425, 1303877941, -1284905200);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483643, -2147483646, 1, 'pla_49697d', 820970595, 1421303999, 'pla_214929', 'pla_924593', 'pla_29e652', -1488156735, -1858644047, -1180042408, 199672698, 2119806856, -1962347906, -866772222, -847293924, -2033879835, 1798111945, NULL, 1, 1, 944975670, -1575410149, -68044929, -1776877925, 1201273976, 1923659053, -1950324754, 2115816682, 76987628, -253138337, 641521863, 304189298, -542502665, 1999335832, -526612570, -546516406, -405743609, -1935752926, -20116244, -176606723);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483642, -2147483647, 1, 'pla_49697d', 1692046802, -1300180872, 'pla_214929', 'pla_924593', 'pla_29e652', -1125548818, 1497321728, -95808609, -244633520, 418247369, -1524425594, -1351793914, 1919033056, -1428186898, -761353513, 1, 1, 1, 362376128, -1311735207, -229022515, -1817527403, -1402164108, 2123471885, -526633767, 448935289, 458835042, 924693315, -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483641, -2147483643, 1, 'pla_49697d', -699574669, 274891948, 'pla_214929', 'pla_924593', 'pla_29e652', 609771851, -1934017803, 1105964624, -663234145, -2013213247, 101754718, 628082526, -1245584612, 1731843275, -582376271, 1, 1, 1, -1165594842, -634585028, 1719800120, -210159774, 270415200, -2071531094, -397848196, -366775518, 575038073, -1161141730, -613916489, 2061558815, 895277769, 364043263, -1177989415, -1352968577, -519515742, 1953495465, -1960313034, 681061317);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (4, -2147483647, 1, 'pla_49697d', 595714424, 1056589776, 'pla_214929', 'pla_924593', 'pla_29e652', -499913447, -360096930, -1942581013, -795975227, 1294064538, 778835680, 1755752040, 1262491793, 450555855, -206528034, -1686002788, -1250380401, 1718516876, -2076274980, 1731324803, -1159083009, -1589605308, -268740517, -564679000, -251205568, 287256667, 1614799674, 1083479253, 1774679448, 205676091, -2094843966, -1048779857, -381485009, 868039568, 503053726, -1897615568, 2085299664, 2038321753);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (5, -2147483646, 1, 'pla_49697d', -841516418, 152478847, 'pla_214929', 'pla_924593', 'pla_29e652', -625404808, -1694533100, -1275298282, 1933158443, 1295379066, 1071401016, 40558455, 740386991, 2018368241, 920097188, -639616320, 1689143863, 237552112, -1046720861, 643589729, -1231488097, 956819642, 774922170, 2105860871, -141591627, 440797047, -732999244, 1654100852, 30861410, -438741674, -154207334, 729449685, -1580984044, 150596046, 431832073, 1510892261, 1677948887, 389700824);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (6, -2147483642, 1, 'pla_49697d', 168442149, 1299171592, 'pla_214929', 'pla_924593', 'pla_29e652', 2066302536, 24053253, -646944990, -1051623642, 2013745856, 917362079, -1312038093, 687330820, -224390110, -1810873111, 1243701948, -156175571, 1220047834, 63063873, -843082635, -285085577, 170892881, -1643065004, -1438303683, -515419519, -1884062674, -531932574, 357443379, -1502591405, -2008781089, 1122899168, -161108900, -735270562, 614314115, 306260487, 1168225104, -499203870, 1509621238);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (7, -2147483644, 1, 'pla_49697d', 1032339628, 608093726, 'pla_214929', 'pla_924593', 'pla_29e652', 1595033206, 1291298007, 1982265552, 2013152515, 1139012231, -951706262, -1324935647, -648564084, -1573704891, -1260548409, 1409697108, -1104749933, 379651188, -592014051, 1744849810, 1996699977, -1027584872, -1685482179, -1391541536, -1025517017, 1374676344, 238243966, -788896327, -1541581575, -325680600, -796609690, -1459013972, -1670335771, 1862728578, 1909521477, 2101986789, 1980131681, 1222311103);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (8, -2147483646, 1, 'pla_49697d', 1784997708, -696672546, 'pla_214929', 'pla_924593', 'pla_29e652', 44959255, -74691962, -2128972904, -1043357093, -753065777, 190510318, -835782528, 192271618, -312228770, 1618264449, 1639204149, -2063751689, 36589303, -1537647691, 364280973, 1592061050, -1451520332, -55270062, -1101814296, 1939337883, -996196097, 986268139, 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 697582781, 428944759, 1446366856, 438933248, 180947503, -622923312);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sprint_speed, agility, acceleration FROM Player_Attributes WHERE player_api_id IN (SELECT player_api_id FROM Player WHERE player_name = 'Alexis Blin');

/*
Gold Result:
(1, 1, 1)
(None, 1, 1)
(1, None, 1)
(1, 1, None)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
*/

-- Prediction Query
SELECT pa.sprint_speed, pa.agility, pa.acceleration FROM Player AS p JOIN Player_Attributes AS pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Alexis Blin';

/*
Prediction Result:
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
(1, 1, None)
(-1250380401, 1718516876, -1686002788)
(1689143863, 237552112, -639616320)
(None, 1, 1)
(1, None, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(1, 1, 1)
(-156175571, 1220047834, 1243701948)
(-1104749933, 379651188, 1409697108)
(-2063751689, 36589303, 1639204149)
*/