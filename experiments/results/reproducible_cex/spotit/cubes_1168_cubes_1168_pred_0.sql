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
INSERT INTO PARTY VALUES (1, 9, 0, 10, 10, 1);
INSERT INTO PARTY VALUES (0, 9, 0, 10, 11, 1);
INSERT INTO HOST VALUES (0, 122, 123, 50);
INSERT INTO HOST VALUES (1, 124, NULL, NULL);
INSERT INTO PARTY_HOST VALUES (0, 0, NULL);
INSERT INTO PARTY_HOST VALUES (1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.party_id AS party_id, LHS.is_main_in_charge AS is_main_in_charge, RHS.party_theme AS party_theme, RHS.location AS LOCATION, RHS.first_year AS first_year, RHS.last_year AS last_year, RHS.number_of_hosts AS number_of_hosts, RHS.party_theme_other AS party_theme_other, RHS.location_other AS location_other, RHS.first_year_other AS first_year_other, RHS.number_of_hosts_other AS number_of_hosts_other FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.party_id AS party_id, RHS.is_main_in_charge AS is_main_in_charge FROM host AS LHS INNER JOIN party_host AS RHS ON (LHS.host_id = RHS.host_id)) AS LHS INNER JOIN (SELECT party_id, party_theme, LOCATION, first_year, first_year AS last_year, number_of_hosts, party_theme_other, location_other, first_year_other, number_of_hosts_other FROM (SELECT number_of_hosts AS party_id, party_theme, LOCATION, first_year, last_year, number_of_hosts, party_theme_other, location_other, first_year_other, number_of_hosts_other FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.party_theme AS party_theme_other, RHS.location AS location_other, RHS.first_year AS first_year_other, RHS.number_of_hosts AS number_of_hosts_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.number_of_hosts = RHS.party_id AND LHS.first_year = RHS.last_year)))) AS RHS ON (LHS.party_id = RHS.party_id)) ORDER BY LOCATION;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT T3.Location FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID WHERE T2.Age > 50;

/*
Prediction Result:
*/