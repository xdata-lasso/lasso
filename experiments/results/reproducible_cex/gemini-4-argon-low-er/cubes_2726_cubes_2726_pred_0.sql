-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "Floors") VALUES ('B1', 10);
INSERT INTO "Institution" ("Institution_id", "building_id") VALUES ('I1', 'B1');
INSERT INTO "protein" ("common_name", "Institution_id") VALUES ('P1', 'I1');
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
(0,)
*/