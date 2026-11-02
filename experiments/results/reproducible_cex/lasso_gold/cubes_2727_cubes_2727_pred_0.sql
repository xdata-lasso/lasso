-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('purpose', 'Patrick Sanchez', '819 Johnson Course
East William, AK 74064', 'decide', 1001, 1002);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('high', 'Patrick Sanchez', '819 Johnson Course
East William, AK 74064', 'decide', 1001, 1002);
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('sense', 'purpose', 'rate', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 1003.5, 'surface', 1004, 'animal', 'show');
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('dark', 'purpose', 'rate', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 1003.5, 'surface', 1004, 'animal', 'show');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('Calvin Nielsen', 'sense', 'Edward Fuller', 1005.5, 'value', 1006.5, 'training');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('Amber Perez', NULL, 'Edward Fuller', 1005.5, 'value', 1006.5, 'training');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT protein_name, institution FROM (SELECT LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, LHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference, RHS.building_id AS building_id FROM protein AS LHS LEFT JOIN institution AS RHS ON (LHS.institution_id = RHS.institution_id)) ORDER BY protein_name, institution NULLS LAST;

/*
Gold Result:
('Edward Fuller', 'rate')
('Edward Fuller', None)
*/

-- Prediction Query
SELECT T2.protein_name, T1.institution FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id;

/*
Prediction Result:
('Edward Fuller', 'rate')
*/