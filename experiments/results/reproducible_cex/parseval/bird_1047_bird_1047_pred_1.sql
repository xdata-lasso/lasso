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
INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483648, 1, 'Francois Affolter', -2147483648, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483647, 1, 'Francois Affolter', -2147483647, 'pla_c01a5d', -1399556171, 1038707349);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483646, 1, 'Francois Affolter', -2147483646, 'pla_c01a5d', 1419861592, 700088193);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483645, 3, 'Francois Affolter', -2147483645, 'pla_c01a5d', 580968159, -1245312912);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483644, 3, 'Francois Affolter', -2147483644, 'pla_c01a5d', 564390026, -1259474148);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483643, 3, 'Francois Affolter', -2147483643, 'pla_c01a5d', -1284905200, 7929158);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (2, 1, 'Francois Affolter', 2, 'pla_c01a5d', -870767087, -1699185893);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (3, 1, 'Francois Affolter', 3, 'pla_c01a5d', 875300074, -1609653472);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483640, 1, 't1__15aa31', -2147483640, 'pla_c01a5d', 748154000, 1148916014);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483639, 1, 'Francois Affolter', -2147483639, 'pla_c01a5d', -586285368, 1664452437);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483638, 1, 'Francois Affolter', -2147483638, 'pla_c01a5d', 2013152515, 1139012231);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (5, 1, 'pla_0d8e0d', -2147483637, 'pla_c01a5d', -753065777, 190510318);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (7, 1, 'pla_0d8e0d', -2147483636, 'pla_c01a5d', -835782528, 192271618);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (4, 1, 'Francois Affolter', -2147483635, 'pla_c01a5d', -1971610898, 2095277250);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (6, 1, NULL, -2147483634, 'pla_c01a5d', 1763821445, 889799750);

-- Inserting into table: player_attributes --
INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483648, -2147483648, 1, '2014-09-18', 1258409369, -1981402255, 'pla_214929', 'pla_924593', 'pla_29e652', -890215420, 1610062532, 1, -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (2, -2147483646, 1, '2014-09-18', -1964997180, 1149850321, 'pla_214929', 'pla_924593', 'pla_29e652', -1833165707, 1155439218, 1, 1313172851, -761141909, 283598170, 742285925, -747753377, 902887186, -967741825, 775304493, 373262291, -472966518, -921187550, -2070843029, 328305758, -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 274769912, -188151580, 226938182, 90119032, -1438850342, -305670381, -1525670226, -453362185, 481163439, 2123196517, 364869063, -953437896);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (3, -2147483647, 1, '2014-09-18', 392822403, 2142703426, 'pla_214929', 'pla_924593', 'pla_29e652', -533293970, 176380444, 1, -977635379, 1661181156, -1372125820, -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, -975213201, -705985602, 537874887, -461695645, 836513442, 176555546, -1937207087, 1675430660, -688509700, -792092619, -1492524358, -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 1298861365, 1968874827, -664193365, -1070063173, 555413010, 722884590);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483645, -2147483647, 2, '2014-09-18', -988981234, -841004020, 'pla_214929', 'pla_924593', 'pla_29e652', -361507387, 401805964, 1, -1485777725, -1255130038, -1762857309, 806170397, 513454646, -688216274, 331812443, 1382410067, 1631231566, 172461907, 1606439408, 1443629118, -155284187, 1686459626, -1554531873, 982314585, 638024588, -688098735, 1784916884, 37673509, 834709651, -348113485, 138842628, -932772113, -639539893, 1255343543, -541746689, 1294666887, -515895469, 1427161052);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483644, -2147483647, 2, '2014-09-18', -1483100200, -7597509, 'pla_214929', 'pla_924593', 'pla_29e652', -1625552518, -1738458256, 1, -1714354341, -458359144, 600440952, 1568069663, -1794176801, -1194675273, -946046410, -902895762, -197933860, 2111987706, -598313376, 1972233925, 1792827279, 804529642, -1538707438, -163600466, -1826414375, 357330522, -683007527, 2035306060, 1523825314, 2078438287, -47052816, 645287482, 765724008, -1099855564, 87529806, -1957268147, -1928431425, 1303877941);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483643, -2147483648, 2, '2014-09-18', -698610044, -1021978385, 'pla_214929', 'pla_924593', 'pla_29e652', 569007824, -1139855872, 1, -288338724, 1897687032, -241848752, 2004147439, -691774480, -1523347137, 1582582341, 453836040, 1467355421, -1171104889, -29242208, 1691780814, 1944978593, 1722106924, -2072838897, -1173368267, 382831862, -406331049, -461418236, -468701684, 1448731351, -604098478, 1248858185, -57705450, -915385605, -2005628382, 1721638020, 983324983, 1269522000, 853709925);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483642, -2147483646, 1, '2014-09-18', -15162884, 1339733032, 'pla_214929', 'pla_924593', 'pla_29e652', -1556979799, -55240145, 1, 1379859112, 195202164, 1817366143, 1615073310, 1055237066, 988954859, -1719383707, 1273687251, 333302050, 1162591638, -2136247961, -1478011227, -2096405521, 1803796945, 872694102, 618058035, 1553368934, -1252009958, 1908593332, 697257217, -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483641, -2147483646, 1, '2014-09-18', -1140595602, -609553675, 'pla_214929', 'pla_924593', 'pla_29e652', 989018473, -55494714, 1, -1674145149, 234957614, 823835795, -354292049, 238533676, -1514700303, -1796351243, -1793230843, -441521858, 2015094998, 1010672881, -1197954156, -2019656607, 375841374, -1449226553, -225238282, -1898678660, 440115543, 292557306, 709097796, -984562992, -605061107, -1689155697, -323362455, 453340472, 211603887, -413043724, 761519897, 1504707292, 955267863);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483640, -2147483645, 1, '2014-09-18', -360096930, -1942581013, 'pla_214929', 'pla_924593', 'pla_29e652', -795975227, 1294064538, 1, 778835680, 1755752040, 1262491793, 450555855, -206528034, -1686002788, -1250380401, 1718516876, -2076274980, 1731324803, -1159083009, -1589605308, -268740517, -564679000, -251205568, 287256667, 1614799674, 1083479253, 1774679448, 205676091, -2094843966, -1048779857, -381485009, 868039568, 503053726, -1897615568, 2085299664, 2038321753, 1376887048, 261633665);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483639, -2147483648, 1, '2014-09-18', -1694533100, -1275298282, 'pla_214929', 'pla_924593', 'pla_29e652', 1933158443, 1295379066, 1, 1071401016, 40558455, 740386991, 2018368241, 920097188, -639616320, 1689143863, 237552112, -1046720861, 643589729, -1231488097, 956819642, 774922170, 2105860871, -141591627, 440797047, -732999244, 1654100852, 30861410, -438741674, -154207334, 729449685, -1580984044, 150596046, 431832073, 1510892261, 1677948887, 389700824, -1853955201, -805997097);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483638, -2147483646, 1, 'AC??$?72(_tSC"', 917362079, -1312038093, 'pla_214929', 'pla_924593', 'pla_29e652', 687330820, -224390110, 1, -1810873111, 1243701948, -156175571, 1220047834, 63063873, -843082635, -285085577, 170892881, -1643065004, -1438303683, -515419519, -1884062674, -531932574, 357443379, -1502591405, -2008781089, 1122899168, -161108900, -735270562, 614314115, 306260487, 1168225104, -499203870, 1509621238, 1432875972, 1032339628, 608093726, 1595033206, 1291298007, 1982265552);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483637, -2147483644, 1, '2014-09-18', -1670945624, 555368535, 'pla_214929', 'pla_924593', 'pla_29e652', -1369148652, 899787662, NULL, 594760660, 833568923, -384749431, -934098178, -827883679, -1872934808, -1974774786, 422046500, -1750715330, 277649518, 908468929, 1149620614, -1414362698, 1046248997, 1584429327, -1575692857, 1570917601, 775289854, -2052350430, 166124233, 1862197286, 1040753276, -324012243, -1333785554, 1784997708, -696672546, 44959255, -74691962, -2128972904, -1043357093);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (4, -2147483638, 1, 'pla_49697d', -312228770, 1618264449, 'pla_214929', 'pla_924593', 'pla_29e652', 1639204149, -2063751689, 36589303, -1537647691, 364280973, 1592061050, -1451520332, -55270062, -1101814296, 1939337883, -996196097, 986268139, 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 697582781, 428944759, 1446366856, 438933248, 180947503, -622923312, 1789767331, 1633584225, 1671062261, -1924635316, 313797011, 1946419004, -1215810104, -982188592, 1981548099, -913430713);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (6, -2147483647, 1, 'pla_49697d', -2121944911, 1195320303, 'pla_214929', 'pla_924593', 'pla_29e652', 1463445550, -1096060187, 2014610660, 1492264835, -642512512, -1040088060, -2081798075, -1439417265, -300547632, -967107842, -1011152325, 1298113538, -1340460158, -2098439423, -459764012, -1148194959, 944310519, 6224071, 1928920679, 1216978423, -1087163929, -1944869637, 658507818, 334376591, 1154884242, 1352531282, -269868995, 580887132, 1188674483, -299585625, -2014514218, -1184608964, 1994296595);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (5, 2, 1, NULL, -1067465394, 1491006943, 'pla_214929', 'pla_924593', 'pla_29e652', -980625770, 721232773, 323781506, 1026055008, -1599077491, 1589523321, 586437419, -711121679, 1977502251, -1094296226, 1913338832, -2061050846, 1893953818, -364462246, 982289268, 493701528, 461842658, -156860347, 1805058154, -270436559, -569461411, 1498496406, 370054768, -1837449583, 1299933788, 679285124, 1752727653, 1394285393, -1052659852, 1092207544, 851545765, 987928936, -1042838119);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (7, -2147483644, 1, '2014-09-18', -1892701926, -460035045, 'pla_214929', 'pla_924593', 'pla_29e652', 1794943626, 886926141, 294604606, -1460437682, 1014069980, 1070869226, -1522433566, -1517668312, 173803229, -1971104604, -526608193, 1560573473, 472597763, 826141460, 1561936884, -516707997, 1014871129, -583955995, -1935855834, 294818731, -563917514, -1195137401, 134065688, 1770139230, -1680744918, -1136928894, -1789708299, -743497747, -1415215611, -251621840, -1720233199, -672126855, -966886446);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t2.heading_accuracy FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Francois Affolter' AND SUBSTRING(t2."date", 1, 10) = '2014-09-18';

/*
Gold Result:
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(294604606,)
*/

-- Prediction Query
SELECT pa.heading_accuracy FROM Player AS p JOIN Player_Attributes AS pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Francois Affolter' AND pa.date = '2014-09-18 00:00:00';

/*
Prediction Result:
*/