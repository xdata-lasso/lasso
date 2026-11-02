-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Science Tower', '100 Main St', '1990-2000', 300, 25);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Beta University', 'Boston', 1900.0, 'Private', 12000, 'Bears', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', NULL, 'Alpha College', 'Austin', 1950.0, 'Public', 25000, 'Eagles', 'South');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B1', NULL, 'Seattle', 1980.0, 'Private', 5000, 'Hawks', 'West');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I4', 'B1', 'Unused Institute', 'Miami', 2000.0, 'Public', 8000, 'Sharks', 'Coastal');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('worm_actin', NULL, 'Actin', 800.5, 'ACC001', 375.0, '85%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('mouse_actin', 'I1', 'Actin', 90.0, 'ACC002', 375.0, '99%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('rat_actin', 'I2', 'Actin', 90.0, 'ACC003', 375.0, '98%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('fly_tubulin', 'I3', 'Tubulin', 700.0, 'ACC004', 450.0, '80%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('yeast_tubulin', 'I2', 'Tubulin', 1100.0, 'ACC005', 445.0, '75%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT protein_name, institution FROM (SELECT LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, LHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference, RHS.building_id AS building_id FROM protein AS LHS LEFT JOIN institution AS RHS ON (LHS.institution_id = RHS.institution_id)) ORDER BY protein_name, institution NULLS LAST;

/*
Gold Result:
('Actin', 'Alpha College')
('Actin', 'Beta University')
('Actin', None)
('Tubulin', 'Alpha College')
('Tubulin', None)
*/

-- Prediction Query
SELECT T2.protein_name, T1.institution FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id;

/*
Prediction Result:
('Actin', 'Beta University')
('Actin', 'Alpha College')
('Tubulin', None)
('Tubulin', 'Alpha College')
*/