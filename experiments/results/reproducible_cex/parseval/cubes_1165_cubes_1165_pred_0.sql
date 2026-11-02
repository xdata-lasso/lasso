-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1, 'par_c4c92d', 'par_114e51', 'par_e49be8', 'par_050bcb', 20);

INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (-2147483647, 'par_a5ac3a', 'par_64edd9', 'par_61c262', 'par_0d70f7', 20);

INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (7, '5k5swwqcgs', '9n8', '4', 'gu7v', 20);

INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (4, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 20);

INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (2, 'bnp', 'mdpos', 'ie5', 'nw6klf', 1038707349);

INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (5, '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 373262291);

-- Inserting into table: host --
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1, 'rhs_410203', 'rhs_0859dc', 'rhs_7b84a1');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483647, 'rhs_70be91', 'rhs_8d8c8c', 'rhs_773587');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483646, 'q_0_690741', 'p5s5bbp', '02eutliqa11r');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (-2147483645, 'q_0_690741', 'ytoo3o9', 'l7');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (3, 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (6, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

-- Inserting into table: party_host --
INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (1, 1, 1);

INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (2, 3, 537874887);

INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (2, 6, 1836127587);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) AS LHS INNER JOIN (SELECT * FROM party WHERE (number_of_hosts >= 20)) AS RHS ON (LHS.party_id = RHS.party_id AND LHS.party_theme = RHS.party_theme AND LHS.location = RHS.location AND LHS.first_year = RHS.first_year AND LHS.last_year = RHS.last_year AND LHS.number_of_hosts = RHS.number_of_hosts)) ORDER BY name;

/*
Gold Result:
('8d99rljsl',)
('klex14ji',)
('rhs_410203',)
*/

-- Prediction Query
SELECT T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID WHERE T3.Number_of_hosts > 20;

/*
Prediction Result:
('klex14ji',)
('8d99rljsl',)
*/