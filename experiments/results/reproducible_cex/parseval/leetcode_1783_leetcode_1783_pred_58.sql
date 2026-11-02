-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: players --
INSERT INTO "players" ("player_id", "player_name") VALUES (1, 'p_s_152179');

INSERT INTO "players" ("player_id", "player_name") VALUES (-2147483647, 'p_s_de1422');

INSERT INTO "players" ("player_id", "player_name") VALUES (3, 'p_s_152179');

INSERT INTO "players" ("player_id", "player_name") VALUES (2, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (5, 'pla_71dfbf');

-- Inserting into table: championships --
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483648, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483647, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483646, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483645, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483644, 1, -2147483647, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483643, 1, -2147483647, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483642, 1, 1, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483641, 1, 1, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483640, 1, 1, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483639, 1, 1, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483638, 1, -2147483647, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483637, -2147483647, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483636, 3, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483635, 1, 1, -2147483647, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483634, 1, 1, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483633, 1, -2147483647, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483632, -2147483647, -2147483647, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483631, 1, -2147483647, -2147483647, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483630, -2147483647, 1, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483629, -2147483647, 3, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483628, -2147483647, 1, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483627, 1, 3, -2147483647, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483626, -2147483647, 2, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483625, 1, 2, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483624, 2, 3, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483623, 5, 1, 2, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483622, 1, 1, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483621, 5, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483620, 5, 1, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483619, 1, 5, 5, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483618, -2147483647, 1, 3, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483617, 5, 2, 2, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483616, 2, 1, 2, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483615, 1, -2147483647, 2, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483614, 5, 1, 3, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483613, 5, 3, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483612, 1, 5, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483611, 1, 2, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483610, 3, 2, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483609, 1, -2147483647, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483608, 2, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483607, 5, 3, 3, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483606, -2147483647, 1, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483605, 2, 2, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483604, 2, 5, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483603, 1, 3, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483602, 2, 1, -2147483647, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483601, 1, -2147483647, 5, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483600, 2, -2147483647, 2, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483599, 1, 1, 3, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483598, 2, 1, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483597, 5, 5, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483596, 3, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483595, 1, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483594, 3, 2, 5, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483593, 3, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483592, 5, 2, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483591, 5, 2, 3, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483590, 5, 1, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483589, 5, 3, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483588, -2147483647, 3, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483587, 1, 2, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483586, 2, 1, 5, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483585, 2, 3, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483584, 2, 3, 2, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483583, 1, 1, 5, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483582, 3, 1, 5, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483581, 2, 5, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483580, 5, 2, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483579, 1, 1, 5, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483578, 1, 2, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483577, 2, 2, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483576, 2, 5, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483575, 5, 3, 3, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483574, -2147483647, 1, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483573, 3, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483572, 3, -2147483647, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483571, 1, 1, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483570, -2147483647, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (2, 3, -2147483647, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (3, 1, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483567, 1, 3, 3, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483566, 1, 1, 2, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483565, 5, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483564, -2147483647, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483563, 1, 5, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483562, 2, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483561, 1, 1, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483560, 1, 1, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483559, 2, 3, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483558, 5, -2147483647, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483557, 1, 3, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483556, 5, 1, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483555, 1, 1, 5, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483554, 2, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483553, 1, 5, 5, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483552, 3, 2, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483551, 1, 1, 3, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483550, -2147483647, 1, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483549, 2, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483548, 1, 1, 5, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483547, 2, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483546, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483545, 1, -2147483647, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483544, -2147483647, 1, 3, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483543, 1, 5, 5, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483542, -2147483647, 1, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483541, 1, 1, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483540, 5, 5, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483539, 1, 1, 5, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483538, 3, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483537, 1, 3, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483536, -2147483647, 1, 2, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483535, 5, 2, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483534, 3, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483533, 1, 3, 5, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483532, 1, 1, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483531, 1, 2, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483530, 2, 1, 2, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483529, 5, 2, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483528, 5, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483527, 1, 3, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483526, -2147483647, -2147483647, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483525, 2, 2, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483524, -2147483647, 1, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483523, 1, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483522, 1, 2, 1, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483521, 1, 2, 2, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483520, 1, 1, 2, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483519, -2147483647, 5, 5, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483518, 3, 1, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483517, 1, 1, 2, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483516, 3, 1, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483515, -2147483647, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483514, -2147483647, 2, 1, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483513, 1, 1, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483512, 2, 1, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483511, -2147483647, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483510, -2147483647, -2147483647, 1, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483509, 1, -2147483647, -2147483647, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483508, -2147483647, 1, 2, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483507, 3, 3, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483506, 5, -2147483647, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483505, 1, 3, 5, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483504, 1, 1, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483503, 5, 2, -2147483647, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483502, -2147483647, 5, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483501, 1, -2147483647, -2147483647, -2147483647);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483500, 1, 1, 2, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483499, -2147483647, -2147483647, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-2147483647, 'p_s_de1422', 107)
(1, 'p_s_152179', 246)
(2, 'pla_71dfbf', 98)
(3, 'p_s_152179', 74)
(5, 'pla_71dfbf', 75)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(GRAND_SLAMS_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID UNION SELECT FR_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN GROUP BY P.PLAYER_ID UNION SELECT US_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN GROUP BY P.PLAYER_ID UNION SELECT AU_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID) AS A GROUP BY PLAYER_ID;

/*
Prediction Result:
(-2147483647, 'p_s_de1422', 107)
(1, 'p_s_152179', 246)
(2, 'pla_71dfbf', 76)
(3, 'p_s_152179', 57)
(5, 'pla_71dfbf', 75)
*/