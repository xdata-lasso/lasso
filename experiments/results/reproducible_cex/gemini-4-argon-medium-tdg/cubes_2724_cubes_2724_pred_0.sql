-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Tower A', '123 Main St', '1990-2000', 500, 40);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Tech Univ', 'Boston', 1900.0, 'Public', 15000, 'Eagles', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B1', 'Art College', 'New York', 1950.0, 'Private', 2000, 'Lions', 'North');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', NULL, 'State Univ', 'Chicago', 1880.0, 'Public', 30000, 'Bears', 'Midwest');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Actin', 0.5, 'ACC1', 375.0, '99%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM institution ORDER BY TYPE;

/*
Gold Result:
('Private',)
('Public',)
*/

-- Prediction Query
SELECT DISTINCT TYPE FROM institution;

/*
Prediction Result:
('Public',)
('Private',)
*/