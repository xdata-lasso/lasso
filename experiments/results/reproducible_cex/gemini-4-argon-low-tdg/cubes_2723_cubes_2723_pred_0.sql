-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic boundary conditions on `Founded` (2002.9, 2003.0, 2003.1), buildings with no institutions, and ordering.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Zeta Tower', '100 Main St', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Alpha Tower', '200 Main St', '2000-2010', 600, 50);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B3', 'Beta Tower', '300 Main St', '2010-2020', 700, 60);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B4', 'Gamma Tower', '400 Main St', '2020-2023', 800, 70);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Inst Just Below', 'City A', 2002.9, 'Public', 1000, 'Lions', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', 'B2', 'Inst Exact Boundary', 'City B', 2003.0, 'Private', 2000, 'Tigers', 'Conf B');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I3', 'B3', 'Inst Just Above', 'City C', 2003.1, 'Public', 3000, 'Bears', 'Conf C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM institution WHERE (founded >= 2003.0)) AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
('Gamma Tower',)
('Zeta Tower',)
*/

-- Prediction Query
SELECT name FROM building EXCEPT SELECT T1.name FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id WHERE T2.founded = 2003;

/*
Prediction Result:
('Beta Tower',)
('Gamma Tower',)
('Zeta Tower',)
*/