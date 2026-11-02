-- Schema DDL
CREATE TABLE "BUILDING" (
    "BUILDING_ID" TEXT,
    "NAME" TEXT,
    "STREET_ADDRESS" TEXT,
    "YEARS_AS_TALLEST" TEXT,
    "HEIGHT_FEET" INT,
    "FLOORS" INT,
    PRIMARY KEY ("BUILDING_ID")
);
CREATE TABLE "INSTITUTION" (
    "INSTITUTION_ID" TEXT,
    "BUILDING_ID" TEXT,
    "INSTITUTION" TEXT,
    "LOCATION" TEXT,
    "FOUNDED" FLOAT,
    "TYPE" TEXT,
    "ENROLLMENT" INT,
    "TEAM" TEXT,
    "PRIMARY_CONFERENCE" TEXT,
    PRIMARY KEY ("INSTITUTION_ID"),
    FOREIGN KEY ("BUILDING_ID") REFERENCES "BUILDING"("BUILDING_ID")
);
CREATE TABLE "PROTEIN" (
    "COMMON_NAME" TEXT,
    "INSTITUTION_ID" TEXT,
    "PROTEIN_NAME" TEXT,
    "DIVERGENCE_FROM_HUMAN_LINEAGE" FLOAT,
    "ACCESSION_NUMBER" TEXT,
    "SEQUENCE_LENGTH" FLOAT,
    "SEQUENCE_IDENTITY_TO_HUMAN_PROTEIN" TEXT,
    PRIMARY KEY ("COMMON_NAME"),
    FOREIGN KEY ("INSTITUTION_ID") REFERENCES "INSTITUTION"("INSTITUTION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BUILDING VALUES (8, 10, 11, 12, 0, 20);
INSERT INTO BUILDING VALUES (7, 13, 14, 15, 0, 0);
INSERT INTO INSTITUTION VALUES (3, 7, 38, 39, 40, 41, 0, 42, 43);
INSERT INTO INSTITUTION VALUES (4, 8, 44, 45, 46, 47, 0, 48, 49);
INSERT INTO PROTEIN VALUES (5, 4, 26, 27, 28, 29, 30);
INSERT INTO PROTEIN VALUES (6, 4, 31, 32, 33, 34, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT floors) AS n_distinct FROM (SELECT * FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference FROM building AS LHS INNER JOIN institution AS RHS ON (LHS.building_id = RHS.building_id)) AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) WHERE (floors <= 20))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id JOIN building AS T3 ON T3.building_id = T1.building_id WHERE T3.floors >= 20;

/*
Prediction Result:
(2,)
*/