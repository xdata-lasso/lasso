-- Schema DDL
CREATE TABLE "PARTY" (
    "PARTY_ID" INT,
    "PARTY_THEME" TEXT,
    "LOCATION" TEXT,
    "FIRST_YEAR" TEXT,
    "LAST_YEAR" TEXT,
    "NUMBER_OF_HOSTS" INT,
    PRIMARY KEY ("PARTY_ID")
);
CREATE TABLE "HOST" (
    "HOST_ID" INT,
    "NAME" TEXT,
    "NATIONALITY" TEXT,
    "AGE" TEXT,
    PRIMARY KEY ("HOST_ID")
);
CREATE TABLE "PARTY_HOST" (
    "PARTY_ID" INT,
    "HOST_ID" INT,
    "IS_MAIN_IN_CHARGE" INT,
    PRIMARY KEY ("PARTY_ID", "HOST_ID"),
    FOREIGN KEY ("PARTY_ID") REFERENCES "PARTY"("PARTY_ID"),
    FOREIGN KEY ("HOST_ID") REFERENCES "HOST"("HOST_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PARTY VALUES (1, 11, 12, 13, 14, 20);
INSERT INTO PARTY VALUES (0, 15, 16, 17, 18, 20);
INSERT INTO HOST VALUES (0, -1, 37, 38);
INSERT INTO HOST VALUES (1, 0, 39, 40);
INSERT INTO PARTY_HOST VALUES (0, 0, 0);
INSERT INTO PARTY_HOST VALUES (0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) AS LHS INNER JOIN (SELECT * FROM party WHERE (number_of_hosts >= 20)) AS RHS ON (LHS.party_id = RHS.party_id AND LHS.party_theme = RHS.party_theme AND LHS.location = RHS.location AND LHS.first_year = RHS.first_year AND LHS.last_year = RHS.last_year AND LHS.number_of_hosts = RHS.number_of_hosts)) ORDER BY name;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID WHERE T3.Number_of_hosts > 20;

/*
Prediction Result:
*/