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
INSERT INTO BUILDING VALUES (11, 0, 0, 0, 0, 0);
INSERT INTO BUILDING VALUES (4, 0, 0, 0, 0, 0);
INSERT INTO INSTITUTION VALUES (8, 11, NULL, 32, 33, 34, 0, 35, 17);
INSERT INTO INSTITUTION VALUES (41, 11, NULL, 42, NULL, 44, 0, 45, 17);
INSERT INTO PROTEIN VALUES (9, 8, 36, 37, 38, 39, 40);
INSERT INTO PROTEIN VALUES (10, 41, 46, 47, NULL, 49, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT institution, n AS count___ FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, RHS.n AS n FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM institution AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) AS LHS INNER JOIN (SELECT building_id, primary_conference, COUNT(*) AS n FROM institution GROUP BY building_id, primary_conference) AS RHS ON (LHS.primary_conference = RHS.primary_conference AND LHS.building_id = RHS.building_id)) ORDER BY institution, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
*/

-- Prediction Query
SELECT T1.institution, COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id GROUP BY T1.institution_id;

/*
Prediction Result:
(None, 1)
(None, 1)
*/