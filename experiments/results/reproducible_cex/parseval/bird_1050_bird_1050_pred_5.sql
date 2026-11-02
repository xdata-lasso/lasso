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
INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (1, 1, 'pla_0d8e0d', -2147483648, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-2147483647, 1, 'pla_0d8e0d', -2147483647, 'pla_c01a5d', 1038707349, 1419861592);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (-1, 3, 'pla_0d8e0d', -2147483646, 'A', 1909986641, 1485335077);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (0, 1, 'pla_0d8e0d', -2147483645, '!', -511185946, -1021749117);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (3, 1, 'pla_0d8e0d', 3, 'pla_c01a5d', -1021978385, 569007824);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (4, 1, 'pla_0d8e0d', -2147483643, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (6, 1, 'pla_0d8e0d', -2147483642, 'pla_c01a5d', -664303813, -1022641847);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (2, 1, 'pla_0d8e0d', -2147483641, 'pla_c01a5d', -55602865, -59984348);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (5, 1, 'pla_0d8e0d', -2147483640, 'pla_c01a5d', 2123196517, 364869063);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (7, 1, 'pla_0d8e0d', -2147483639, 'pla_c01a5d', 1129658414, 1250290042);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (8, 1, 'pla_0d8e0d', -2147483638, 'pla_c01a5d', -1300180872, -1125548818);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (9, 1, 'pla_0d8e0d', -2147483637, 'pla_c01a5d', 1262491793, 450555855);

INSERT INTO "player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (10, 1, 'pla_0d8e0d', -2147483636, 'pla_c01a5d', 63063873, -843082635);

-- Inserting into table: player_attributes --
INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (1, -2147483648, 1, 'pla_49697d', 1258409369, -1981402255, 't2__8ae30b', 'pla_924593', 'pla_29e652', -890215420, 1610062532, -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (3, -2147483648, 1, 'pla_49697d', 1274489983, -1683203397, 't2__8ae30b', 'pla_924593', 'pla_29e652', 528680845, -1585009206, -53231346, -443340271, 757448742, -1179823637, 1119186446, 781505063, 418417917, -1031969798, -1106983592, 1884179925, 902551284, 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (0, -2147483647, 1, 'pla_49697d', -533293970, 176380444, 't2__e676b1', 'pla_924593', 'pla_29e652', -977635379, 1661181156, -1372125820, -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, -975213201, -705985602, 537874887, -461695645, 836513442, 176555546, -1937207087, 1675430660, -688509700, -792092619, -1492524358, -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 1298861365, 1968874827, -664193365, -1070063173, 555413010, 722884590, 580968159, -1245312912, 1575412235);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483645, -2147483647, 1, 'pla_49697d', -841004020, -361507387, 't2__e676b1', 'pla_924593', 'pla_29e652', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 513454646, -688216274, 331812443, 1382410067, 1631231566, 172461907, 1606439408, 1443629118, -155284187, 1686459626, -1554531873, 982314585, 638024588, -688098735, 1784916884, 37673509, 834709651, -348113485, 138842628, -932772113, -639539893, 1255343543, -541746689, 1294666887, -515895469, 1427161052, 564390026, -1259474148);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483644, -2147483647, 1, 'pla_49697d', 1746373317, 1360271423, 't2__e676b1', 'pla_924593', 'pla_29e652', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 678047687, -1478134144, -491938169, -106471771, 1235416111, 1923912467, 518609210, 1948383687, 1476361420, 195720193, 1774087382, 1732258051, -1762140823, 1371234901, -290314193, 76996700, -435350511, 1992637800, -820614248, 481546706, -1784554553, -242584410, -698610044);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (2, -2147483648, 1, 'pla_49697d', -890215420, 1610062532, 'pla_214929', 'pla_924593', 'pla_29e652', -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, 1419861592);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (5, -2147483643, 1, 'pla_49697d', -1964997180, 1149850321, 'pla_214929', 'pla_924593', 'pla_29e652', -1833165707, 1155439218, 1313172851, -761141909, 283598170, 742285925, -747753377, 902887186, -967741825, 775304493, 373262291, -472966518, -921187550, -2070843029, 328305758, -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 274769912, -188151580, 226938182, 90119032, -1438850342, -305670381, -1525670226, -453362185, 481163439, 2123196517, 364869063, -953437896, -1097120355);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483641, -2147483643, 1258409369, 'pla_49697d', -1981402255, -890215420, NULL, 'pla_924593', 'pla_29e652', 1610062532, -106629402, 1871297066, 809183447, 89267185, -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 700293388, 906324270, 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 1526238907, -1377057208, -841692980, -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 1038707349);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (4, -2147483642, 1, 'pla_49697d', 546571701, 947159877, 'pla_214929', 'pla_924593', 'pla_29e652', 1990080517, 1408123494, -1964997180, 1149850321, -1833165707, 1155439218, 1313172851, -761141909, 283598170, 742285925, -747753377, 902887186, -967741825, 775304493, 373262291, -472966518, -921187550, -2070843029, 328305758, -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 274769912, -188151580, 226938182, 90119032, -1438850342, -305670381, -1525670226, -453362185, 481163439);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483639, 3, -1021749117, 'pla_49697d', 392822403, 2142703426, NULL, 'pla_924593', 'pla_29e652', -533293970, 176380444, -977635379, 1661181156, -1372125820, -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, -975213201, -705985602, 537874887, -461695645, 836513442, 176555546, -1937207087, 1675430660, -688509700, -792092619, -1492524358, -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 1298861365, 1968874827, -664193365, -1070063173, 555413010, 722884590, 580968159);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (6, -2147483645, 1, 'pla_49697d', -1106350634, -1509264256, 'pla_214929', 'pla_924593', 'pla_29e652', -792947627, -1898531797, -1748371085, -1742081330, 894242932, -211209314, -1056308489, -1454058168, -2078052421, -512640349, 1038566008, 32204797, -1672720816, -1520489792, -658391922, -1388029300, -566887085, 602161869, 1350414441, 2094425101, -961217731, -1888505890, 777149609, 61479715, -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 1449284300, -977470238, -1478247928, 1074760385);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483637, -2147483647, -1194675273, 'pla_49697d', -946046410, -902895762, NULL, 'pla_924593', 'pla_29e652', -197933860, 2111987706, -598313376, 1972233925, 1792827279, 804529642, -1538707438, -163600466, -1826414375, 357330522, -683007527, 2035306060, 1523825314, 2078438287, -47052816, 645287482, 765724008, -1099855564, 87529806, -1957268147, -1928431425, 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 820970595, 1421303999, -1488156735, -1858644047, -1180042408, 199672698, 2119806856);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (7, -2147483640, 1, 'pla_49697d', 2004147439, -691774480, 'pla_214929', 'pla_924593', 'pla_29e652', -1523347137, 1582582341, 453836040, 1467355421, -1171104889, -29242208, 1691780814, 1944978593, 1722106924, -2072838897, -1173368267, 382831862, -406331049, -461418236, -468701684, 1448731351, -604098478, 1248858185, -57705450, -915385605, -2005628382, 1721638020, 983324983, 1269522000, 853709925, -870767087, -1699185893, 875300074, -1609653472, -1405314653, 1816660482, -1212676731, 1692046802);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483635, 3, -95808609, 'pla_49697d', -244633520, 418247369, NULL, 'pla_924593', 'pla_29e652', -1524425594, -1351793914, 1919033056, -1428186898, -761353513, 362376128, -1311735207, -229022515, -1817527403, -1402164108, 2123471885, -526633767, 448935289, 458835042, 924693315, -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274, -1140595602, -609553675, 989018473, -55494714);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (8, -2147483647, 1, 'pla_49697d', 101754718, 628082526, 'pla_214929', 'pla_924593', 'pla_29e652', -1245584612, 1731843275, -582376271, -1165594842, -634585028, 1719800120, -210159774, 270415200, -2071531094, -397848196, -366775518, 575038073, -1161141730, -613916489, 2061558815, 895277769, 364043263, -1177989415, -1352968577, -519515742, 1953495465, -1960313034, 681061317, 1935791961, 595714424, 1056589776, -499913447, -360096930, -1942581013, -795975227, 1294064538, 778835680, 1755752040);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483633, -2147483641, -277407746, 'pla_49697d', -670154354, -2140468103, NULL, 'pla_924593', 'pla_29e652', 469838697, 1468640756, 1048147204, -1814875250, -647898186, -1610380698, -457369423, 1557188093, 548968280, -1552469358, 7342822, -1034034171, 1244279905, -1396673167, 412199481, 727608179, 456034296, -628433041, 1044710644, 966412849, -2061634386, -850941333, -1216952047, -457901285, -2140923099, -841516418, 152478847, -625404808, -1694533100, -1275298282, 1933158443, 1295379066, 1071401016);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (9, -2147483642, 1, 'pla_49697d', 1514371324, -379749892, 'pla_214929', 'pla_924593', 'pla_29e652', -541917667, -961629819, 2012400150, -505019168, 1968783602, 125495479, 312804300, -246257698, -516345261, -1191116453, 1709667347, -1934709172, -2121397544, 1595632888, 2072023304, 789756515, -1160642134, 769234989, 168442149, 1299171592, 2066302536, 24053253, -646944990, -1051623642, 2013745856, 917362079, -1312038093, 687330820, -224390110, -1810873111, 1243701948, -156175571, 1220047834);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (-2147483631, -2147483642, -1971560508, 'pla_49697d', 1728926031, -63214972, NULL, 'pla_924593', 'pla_29e652', 1106724223, 1966809332, 1487347213, 1328948152, -1923069176, -1520090613, 591870819, 729543907, -2108844113, 973811121, 280292620, 620355627, -531872415, -2125172723, 339193890, -493230039, -2081662466, -1941472821, -2082238979, -845136979, -1042976410, -1670945624, 555368535, -1369148652, 899787662, 594760660, 833568923, -384749431, -934098178, -827883679, -1872934808, -1974774786, 422046500);

INSERT INTO "player_attributes" ("id", "player_fifa_api_id", "player_api_id", "date", "overall_rating", "potential", "preferred_foot", "attacking_work_rate", "defensive_work_rate", "crossing", "finishing", "heading_accuracy", "short_passing", "volleys", "dribbling", "curve", "free_kick_accuracy", "long_passing", "ball_control", "acceleration", "sprint_speed", "agility", "reactions", "balance", "shot_power", "jumping", "stamina", "strength", "long_shots", "aggression", "interceptions", "positioning", "vision", "penalties", "marking", "standing_tackle", "sliding_tackle", "gk_diving", "gk_handling", "gk_kicking", "gk_positioning", "gk_reflexes") VALUES (10, -2147483648, 1, 'pla_49697d', 1374676344, 238243966, 'pla_214929', 'pla_924593', 'pla_29e652', -788896327, -1541581575, -325680600, -796609690, -1459013972, -1670335771, 1862728578, 1909521477, 2101986789, 1980131681, 1222311103, 2141720493, 1793241362, -1304516770, -1558272216, 195316816, 1728201214, -1370566258, 948460309, 1183069552, -1057355067, -1004098188, 316163741, -752650834, 2134937984, 1379644459, 136003842, -1486030107, 1138926079, -609840352, 486475144, -679850352, 1205111943);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t2.preferred_foot FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t1.birthday DESC, t1.id NULLS LAST, t2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__e676b1',)
*/

-- Prediction Query
SELECT PA.preferred_foot FROM Player AS P INNER JOIN Player_Attributes AS PA ON P.player_api_id = PA.player_api_id WHERE P.birthday = (SELECT MAX(birthday) FROM Player);

/*
Prediction Result:
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('pla_214929',)
('t2__8ae30b',)
('t2__8ae30b',)
('t2__e676b1',)
('t2__e676b1',)
('t2__e676b1',)
*/