-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: host --
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483648, 'hos_4d3023', 'hos_040eb4', '5k5swwqcgs');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483647, 'hos_4d3023', 'hos_040eb4', '9n8');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483646, 'hos_4d3023', 'hos_040eb4', '4');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483645, 'hos_4d3023', 'hos_040eb4', 'gu7v');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483644, 'hos_4d3023', 'hos_040eb4', 'e4');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483643, 'hos_4d3023', 'hos_040eb4', 'hria2ypuzhs');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483642, 'hos_4d3023', NULL, 'rwbbp6luhvd');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483641, 'hos_4d3023', NULL, 'tti');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483640, 'hos_4d3023', NULL, 'bnp');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483639, NULL, 'hos_040eb4', 'mdpos');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483638, NULL, 'hos_040eb4', 'ie5');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483637, NULL, 'hos_040eb4', 'nw6klf');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483636, 'hos_4d3023', 'hos_040eb4', 'a9000t5c4eci');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483635, 'hos_4d3023', 'hos_040eb4', 'gce376nium52');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483634, 'hos_4d3023', 'hos_040eb4', 'zbuo4nrqrof');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483633, 'hos_4d3023', 'hos_040eb4', 'qyp5s5bbp0');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483632, 'hos_4d3023', 'hos_040eb4', '2eutliqa11r');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483631, 'hos_4d3023', 'hos_040eb4', 'ytoo3o9');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483630, 'hos_4d3023', 'hos_040eb4', 'l7');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483629, 'hos_4d3023', 'hos_040eb4', 'klex14ji');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483628, 'hos_4d3023', 'hos_040eb4', '7zwau2dwyr');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483627, 'hos_4d3023', 'hos_040eb4', '13pyu');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483626, 'hos_4d3023', 'hos_040eb4', '8d99rljsl');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483625, 'hos_4d3023', 'hos_040eb4', 'b4yp5qi');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483624, 'hos_4d3023', 'hos_040eb4', 'rkf9vqx5');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483623, 'hos_4d3023', 'hos_040eb4', 'pz0f8jegd');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483622, 'hos_4d3023', 'hos_040eb4', '1vy9uxj4');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483621, 'hos_4d3023', 'hos_040eb4', 'wb');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483620, 'hos_4d3023', 'hos_040eb4', 'v');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483619, 'hos_4d3023', 'hos_040eb4', 'ph2');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483618, 'hos_4d3023', 'hos_040eb4', 'nd');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483617, 'hos_4d3023', 'hos_040eb4', 'wnqcx');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483616, 'hos_4d3023', 'hos_040eb4', '5hncprjtu0d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT name, nationality, COUNT(*) AS n FROM host GROUP BY name, nationality) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Nationality FROM HOST GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('hos_040eb4',)
*/