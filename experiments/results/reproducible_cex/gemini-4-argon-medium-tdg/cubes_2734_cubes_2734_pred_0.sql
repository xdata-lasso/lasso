-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary values for height_feet (199, 200, 201) and floors (19, 20, 21), along with AND vs OR logic.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b1', 'Tower A', '100 Main St', '1990-2000', 200, 25);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b2', 'Tower B', '101 Main St', '2000-2005', 250, 20);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b3', 'Tower C', '102 Main St', '2005-2010', 250, 19);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b4', 'Tower D', '103 Main St', '2010-2015', 199, 21);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b5', 'Tower E', '104 Main St', '2015-2020', 201, 21);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b6', 'Tower F', '105 Main St', '2020-2022', 200, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM building WHERE (height_feet <> 200 AND floors > 20) ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
('Tower D',)
('Tower E',)
*/

-- Prediction Query
SELECT name FROM building WHERE height_feet >= 200 AND floors >= 20;

/*
Prediction Result:
('Tower A',)
('Tower B',)
('Tower E',)
('Tower F',)
*/