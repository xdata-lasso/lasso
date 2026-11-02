-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', NULL, 'Standalone Institute', 'Boston', 1901.0, 'Private', 1500, 'Eagles', 'East');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Actin', 0.5, 'ACC001', 375.0, '99%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P2', NULL, 'Myosin', 1.2, 'ACC002', 450.0, '95%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM building ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM building;

/*
Prediction Result:
(0,)
*/