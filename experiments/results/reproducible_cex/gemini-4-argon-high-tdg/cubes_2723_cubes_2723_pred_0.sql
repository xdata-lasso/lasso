-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b1', 'Zeta Tower', '100 Main St', '1980-1990', 800, 60);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b2', 'Beta Hall', '200 Oak Ave', '1990-1995', 600, 45);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b3', 'Gamma Center', '300 Pine Rd', '1995-2000', 900, 70);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b4', 'Alpha Plaza', '400 Elm St', '2000-2010', 1100, 85);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b5', 'Delta Annex', '500 Maple Dr', '1970-1980', 500, 35);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('i1', 'b2', 'Beta College', 'Eastside', 2002.9, 'Private', 1500, 'Bears', 'East Conf');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('i2', 'b3', 'Gamma Institute', 'Midtown', 2003.0, 'Public', 3000, 'Gators', 'Central Conf');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('i3', 'b4', 'Alpha University', 'Downtown', 2003.1, 'Public', 5000, 'Aces', 'Metro Conf');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('i4', 'b5', 'Delta Academy', 'Westside', 1995.0, 'Private', 1200, 'Dolphins', 'West Conf');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('p1', 'i1', 'Actin', 1.2, 'ACC001', 375.0, '99%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM institution WHERE (founded >= 2003.0)) AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
('Beta Hall',)
('Delta Annex',)
('Zeta Tower',)
*/

-- Prediction Query
SELECT name FROM building EXCEPT SELECT T1.name FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id WHERE T2.founded = 2003;

/*
Prediction Result:
('Alpha Plaza',)
('Beta Hall',)
('Delta Annex',)
('Zeta Tower',)
*/