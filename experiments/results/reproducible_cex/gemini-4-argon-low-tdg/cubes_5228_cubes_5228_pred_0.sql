-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Alpha Tower', '100 Main St', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Beta Complex', '200 Oak Ave', '2000-2010', 600, 50);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B3', 'Alpha Tower', '300 Pine Rd', '2010-2020', 700, 60);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B4', 'Gamma Hall', '400 Elm St', '1980-1990', 400, 30);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Tech Univ', 'City A', 1900.0, 'Public', 10000, 'Lions', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', 'B1', 'Science Inst', 'City A', 1950.0, 'Private', 5000, 'Tigers', 'Conf B');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I3', 'B1', 'Art College', 'City A', 1980.0, 'Private', 2000, 'Bears', 'Conf C');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I4', 'B2', 'State Univ', 'City B', 1850.0, 'Public', 25000, 'Eagles', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I5', 'B3', 'Med School', 'City C', 2000.0, 'Public', 3000, 'Hawks', 'Conf B');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I6', NULL, 'Online Univ', 'Web', 2010.0, 'Private', 50000, 'None', 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.n AS n FROM building AS LHS INNER JOIN (SELECT building_id, COUNT(*) AS n FROM institution GROUP BY building_id) AS RHS ON (LHS.building_id = RHS.building_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alpha Tower', 1)
('Alpha Tower', 3)
('Beta Complex', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id GROUP BY T1.building_id;

/*
Prediction Result:
('Alpha Tower', 3)
('Beta Complex', 1)
('Alpha Tower', 1)
*/