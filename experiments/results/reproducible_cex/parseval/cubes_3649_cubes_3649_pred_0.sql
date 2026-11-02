-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: pilot --
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1, 'pil_3c685f', -55602865, 1, 'pil_3906d2', 'pil_dd373d', 1, 'pil_929fdb');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483647, 'swwqcgsk', 1610062532, -106629402, 'u7', NULL, -734455130, '4h');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483646, 'ia2yp', NULL, -1670923962, 'rwbbp6luhvd', 'tti', -1364429300, 'nprmdposii');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483645, NULL, -1823627488, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206, '52zb');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483644, 'uo4nrqrofqy', -1106983592, 1884179925, 'bbp02eut', 'iqa', -314162272, NULL);

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483643, 'ytoo3o9', -1666765085, 1178636309, 'ex1', 'ji7zwau2', NULL, 'dwyrq13pyu78');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483642, '9', 244829661, NULL, 'jsl', 'b4yp5qi', -227162283, 'f9v');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483641, 'x58pz', -1529584866, 1196308825, NULL, 'd21vy9uxj4hw', -2050247126, 'lph2gn');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (2, 'q', -664193365, -1070063173, 'x5hncprjtu0', 'z', -1748371085, 'q8');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (3, 'n2f3dqv0gcb9', 172461907, 1606439408, '3zb', 'lyr', 1038566008, 'n6vck6ah0f');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (4, 'jswwlq7xb', 602161869, 1350414441, 'a7ryfd', 'z16ni', 2011234363, 'ai5');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (5, 'h', 1583472758, 1449284300, 'gjd8y', 't1afgog', -946046410, 'tsj3ayxp1q4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT join_year FROM (SELECT LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team, RHS.pilot_id AS pilot_id_other, RHS.pilot_name AS pilot_name_other, RHS.age AS age_other, RHS.nationality AS nationality_other, RHS.position AS position_other, RHS.team AS team_other FROM pilot AS LHS INNER JOIN (SELECT pilot_id, pilot_name, MIN(rank) OVER () AS rank, age, nationality, POSITION, join_year, team FROM pilot) AS RHS ON (LHS.join_year = RHS.join_year AND LHS.rank = RHS.rank)) ORDER BY join_year;

/*
Gold Result:
(-1585009206,)
*/

-- Prediction Query
SELECT Join_Year FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1364429300,)
*/