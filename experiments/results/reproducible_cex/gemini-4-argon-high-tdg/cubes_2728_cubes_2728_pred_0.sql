-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B03', 'Metro Tower', '100 Low St', '1990-1995', 500, 30);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B01', 'Metro Tower', '500 Mid St', '1980-1990', 900, 10);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B02', 'Metro Tower', '900 High St', '1995-2000', 100, 50);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B09', 'Apex Center', '42 First Ave', '2000-2010', 1200, 85);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B00', 'Zenith Plaza', '77 Sunset Blvd', '2010-2020', 300, 22);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I01', 'B01', 'Metro University', 'New York', 1901.0, 'Private', 15000, 'Metros', 'East Coast');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('Hemoglobin', 'I01', 'HBB', 0.05, 'ACC001', 147.0, '99%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, street_address, floors FROM building ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
('Apex Center', '42 First Ave', 85)
('Metro Tower', '500 Mid St', 10)
('Metro Tower', '900 High St', 50)
('Metro Tower', '100 Low St', 30)
('Zenith Plaza', '77 Sunset Blvd', 22)
*/

-- Prediction Query
SELECT name, street_address, floors FROM building ORDER BY floors, building.building_id NULLS LAST;

/*
Prediction Result:
('Metro Tower', '500 Mid St', 10)
('Zenith Plaza', '77 Sunset Blvd', 22)
('Metro Tower', '100 Low St', 30)
('Metro Tower', '900 High St', 50)
('Apex Center', '42 First Ave', 85)
*/