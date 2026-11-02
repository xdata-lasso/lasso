-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Science Tower', '100 Main St', '1990-2005', 450, 35);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B2', 'Founders Hall', '200 Oak Ave', '1950-1990', 220, 18);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B3', 'Civic Center', '300 Pine Rd', '2005-Present', 600, 50);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Zeta University', 'New York', 2000.0, 'Public', 50000, 'Lions', 'East Coast');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B2', 'Alpha College', 'Boston', 1850.0, 'Private', 2000, 'Bears', 'New England');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B1', 'Beta State', 'Chicago', 1950.0, 'Public', 30000, 'Eagles', 'Midwest');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I4', 'B3', 'Gamma Institute', 'Seattle', 1900.0, 'Liberal Arts', 1500, 'Hawks', 'Pacific');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Hemoglobin', 12.5, 'ACC001', 141.0, '98%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P2', 'I1', 'Myoglobin', 15.0, 'ACC002', 154.0, '95%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM institution ORDER BY TYPE;

/*
Gold Result:
('Liberal Arts',)
('Private',)
('Public',)
*/

-- Prediction Query
SELECT DISTINCT TYPE FROM institution;

/*
Prediction Result:
('Public',)
('Private',)
('Liberal Arts',)
*/