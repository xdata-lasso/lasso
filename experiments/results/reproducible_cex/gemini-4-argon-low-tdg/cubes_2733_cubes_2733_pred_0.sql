-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for Founded (1990.0) and Enrollment (1000), plus logical AND vs OR
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', NULL, 'Inst1', 'Loc1', 1990.0, 'Public', 1001, 'T1', 'C1');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', NULL, 'Inst2', 'Loc2', 1989.9, 'Private', 1001, 'T2', 'C2');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I3', NULL, 'Inst3', 'Loc3', 1990.0, 'Research', 1000, 'T3', 'C3');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I4', NULL, 'Inst4', 'Loc4', 1990.1, 'Community', 999, 'T4', 'C4');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I5', NULL, 'Inst5', 'Loc5', 1980.0, 'Liberal Arts', 1000, 'T5', 'C5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM institution WHERE (founded >= 1990.0 AND enrollment <> 1000) ORDER BY TYPE, institution.institution_id NULLS LAST;

/*
Gold Result:
('Community',)
('Public',)
*/

-- Prediction Query
SELECT TYPE FROM institution WHERE founded > 1990 AND enrollment >= 1000;

/*
Prediction Result:
*/