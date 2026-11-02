-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests NULL handling in projected columns and ORDER BY columns (including NULLS LAST on building_id and NULLs in Name)
-- In SQLite, TEXT PRIMARY KEY allows NULL values.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES (NULL, 'Null ID Tower', '999 Nowhere', NULL, NULL, 10);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Null ID Tower', '998 Nowhere', '1999', 200, 20);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', NULL, '123 Anon St', '2001', 300, NULL);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B0', NULL, NULL, '2002', 350, 25);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B3', 'Zeta Tower', NULL, '2020', 500, 45);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, street_address, floors FROM building ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
(None, None, 25)
(None, '123 Anon St', None)
('Null ID Tower', '998 Nowhere', 20)
('Null ID Tower', '999 Nowhere', 10)
('Zeta Tower', None, 45)
*/

-- Prediction Query
SELECT name, street_address, floors FROM building ORDER BY floors, building.building_id NULLS LAST;

/*
Prediction Result:
(None, '123 Anon St', None)
('Null ID Tower', '999 Nowhere', 10)
('Null ID Tower', '998 Nowhere', 20)
(None, None, 25)
('Zeta Tower', None, 45)
*/