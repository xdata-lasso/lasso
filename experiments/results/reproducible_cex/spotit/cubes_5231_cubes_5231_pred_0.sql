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
INSERT INTO BUILDING VALUES (-1, 0, 16, 17, 1, 0);
INSERT INTO BUILDING VALUES (0, -1, 18, 19, 1, 0);
INSERT INTO INSTITUTION VALUES (2, -1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO INSTITUTION VALUES (3, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PROTEIN VALUES (4, 2, 0, 0, 0, 0, 0);
INSERT INTO PROTEIN VALUES (5, 3, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors FROM building AS LHS INNER JOIN (SELECT MAX(height_feet) AS maxheight_feet FROM building) AS RHS ON (LHS.height_feet = RHS.maxheight_feet)) ORDER BY name;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT name FROM building ORDER BY height_feet DESC, building.building_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/