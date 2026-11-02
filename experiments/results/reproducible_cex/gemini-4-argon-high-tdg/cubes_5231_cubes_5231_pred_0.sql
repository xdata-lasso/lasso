-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Zebra Tower', '100 Main St', '1990-2000', 100, 10);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B2', 'Alpha Tower', '200 Oak Ave', '2000-2010', 100, 20);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B3', 'Beta Tower', '300 Pine Rd', '1980-1990', 90, 50);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B2', 'Alpha Tech', 'New York', 1901.0, 'Private', 5000, 'Lions', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B2', 'Alpha College', 'New York', 1920.0, 'Public', 8000, 'Tigers', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B3', 'Beta University', 'Boston', 1850.0, 'Private', 12000, 'Bears', 'North');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Actin', 0.5, 'ACC001', 375.0, '99%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P2', 'I3', 'Myosin', 1.2, 'ACC002', 1938.0, '95%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors FROM building AS LHS INNER JOIN (SELECT MAX(height_feet) AS maxheight_feet FROM building) AS RHS ON (LHS.height_feet = RHS.maxheight_feet)) ORDER BY name;

/*
Gold Result:
('Alpha Tower',)
('Zebra Tower',)
*/

-- Prediction Query
SELECT name FROM building ORDER BY height_feet DESC, building.building_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra Tower',)
*/