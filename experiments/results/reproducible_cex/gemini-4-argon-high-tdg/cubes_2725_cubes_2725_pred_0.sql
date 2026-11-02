-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B2', 'Meridian Center', '200 Oak Ave', '1970-1989', 900, 20);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Apex Tower', '100 Main St', '1990-2005', 400, 30);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B3', 'Crown Plaza', '300 Pine Rd', '1950-1969', 600, 80);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B2', 'Metro University', 'New York', 1901.0, 'Private', 15000, 'Lions', 'East League');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B3', 'State College', 'Boston', 1885.0, 'Public', 25000, 'Eagles', 'North League');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Actin', 1.5, 'AC101', 375.0, '99%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P2', 'I2', 'Myosin', 2.3, 'AC102', 1900.0, '95%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM building ORDER BY years_as_tallest DESC, building.building_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Apex Tower',)
*/

-- Prediction Query
SELECT name FROM building ORDER BY height_feet DESC, building.building_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Meridian Center',)
*/