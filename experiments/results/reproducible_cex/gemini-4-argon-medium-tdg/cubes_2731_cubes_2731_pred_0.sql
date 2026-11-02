-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Tower A', '123 Main St', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Tower B', '456 Oak St', '2000-2010', 600, 50);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_B', 'B1', 'Alpha Univ', 'Loc_A1', 1990.1, 'Private', 1000, 'T1', 'C1');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_A', 'B2', 'Alpha Univ', 'Loc_A2', 2005.0, 'Private', 2000, 'T2', 'C2');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_C', NULL, 'Beta College', 'Loc_B1', 1995.0, 'Private', 1500, 'T3', 'C1');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_D', 'B1', 'Boundary 1990', 'Loc_Bound', 1990.0, 'Private', 1200, 'T4', 'C3');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_E', 'B1', 'Old Private', 'Loc_Old', 1989.9, 'Private', 1200, 'T5', 'C3');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_F', 'B1', 'Public New', 'Loc_Pub', 2000.0, 'Public', 5000, 'T6', 'C4');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I_G', 'B1', 'Case Test', 'Loc_Case', 2000.0, 'private', 3000, 'T7', 'C4');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P1', 'I_A', 'ProtA1', 1.2, 'ACC1', 100.0, '99%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P2', 'I_A', 'ProtA2', 1.5, 'ACC2', 150.0, '95%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "institution", "location" FROM "institution" WHERE ("type" = 'Private' AND founded > 1990.0) ORDER BY institution, institution.institution_id NULLS LAST;

/*
Gold Result:
('Alpha Univ', 'Loc_A2')
('Alpha Univ', 'Loc_A1')
('Beta College', 'Loc_B1')
*/

-- Prediction Query
SELECT institution, LOCATION FROM institution WHERE founded > 1990 AND TYPE = 'Private';

/*
Prediction Result:
('Alpha Univ', 'Loc_A1')
('Alpha Univ', 'Loc_A2')
('Beta College', 'Loc_B1')
*/