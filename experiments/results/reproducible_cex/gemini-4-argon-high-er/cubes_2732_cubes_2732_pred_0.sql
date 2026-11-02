-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b1', 'Tower B', '123 Main St', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b2', 'Tower A', '456 Oak St', '2000-2010', 600, 50);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('i1', NULL, 'Test Institute', 'City', 1950.0, 'Public', 1000, 'Tigers', 'Conf A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM institution AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
('Tower A',)
('Tower B',)
*/

-- Prediction Query
SELECT name FROM building WHERE NOT building_id IN (SELECT building_id FROM institution);

/*
Prediction Result:
*/