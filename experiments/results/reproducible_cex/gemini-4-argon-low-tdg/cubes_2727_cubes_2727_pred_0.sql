-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LEFT JOIN vs INNER JOIN (protein with NULL Institution_id),
-- ORDER BY protein_name ASC, and tie-breaking ORDER BY institution ASC NULLS LAST.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Science Tower', '100 Main St', '1990-2000', 300, 20);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Beta University', 'City B', 1950.0, 'Public', 15000, 'Bears', 'Conf B');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', NULL, 'Alpha College', 'City A', 1900.0, 'Private', 5000, 'Eagles', 'Conf A');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P1', 'I1', 'Actin', 10.5, 'ACC1', 375.0, '99%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P2', NULL, 'Actin', 12.0, 'ACC2', 375.0, '98%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P3', 'I2', 'Actin', 15.0, 'ACC3', 375.0, '95%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P4', 'I1', 'Collagen', 5.0, 'ACC4', 1000.0, '90%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT protein_name, institution FROM (SELECT LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, LHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference, RHS.building_id AS building_id FROM protein AS LHS LEFT JOIN institution AS RHS ON (LHS.institution_id = RHS.institution_id)) ORDER BY protein_name, institution NULLS LAST;

/*
Gold Result:
('Actin', 'Alpha College')
('Actin', 'Beta University')
('Actin', None)
('Collagen', 'Beta University')
*/

-- Prediction Query
SELECT T2.protein_name, T1.institution FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id;

/*
Prediction Result:
('Actin', 'Beta University')
('Actin', 'Alpha College')
('Collagen', 'Beta University')
*/