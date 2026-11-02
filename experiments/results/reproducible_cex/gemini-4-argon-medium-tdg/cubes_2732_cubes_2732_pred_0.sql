-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering, duplicate building names without DISTINCT, and multiple institutions per building.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Zeta Tower', '100 Main St', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Alpha Hall', '200 Oak St', '1980-1990', 300, 25);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B3', 'Beta Plaza', '300 Pine St', '2000-2010', 600, 50);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B4', 'Alpha Hall', '400 Elm St', '2010-2020', 700, 60);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B3', 'Tech Univ', 'City A', 1900.0, 'Public', 10000, 'Tigers', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', 'B3', 'State College', 'City A', 1950.0, 'Public', 5000, 'Bears', 'Conf B');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P1', 'I1', 'Albumin', 0.5, 'ACC1', 585.0, '99%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM institution AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
('Alpha Hall',)
('Alpha Hall',)
('Zeta Tower',)
*/

-- Prediction Query
SELECT name FROM building WHERE NOT building_id IN (SELECT building_id FROM institution);

/*
Prediction Result:
('Zeta Tower',)
('Alpha Hall',)
('Alpha Hall',)
*/