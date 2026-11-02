-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO building (building_id, name, street_address, years_as_tallest, height_feet, floors) VALUES ('default2', 'default1', 'default1', 'default1', NULL, 1), ('default1', NULL, 'default1', 'default2', 1, NULL), ('unique_2', NULL, NULL, NULL, 0, 1), ('unique_3', 'default2', NULL, NULL, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, street_address, floors FROM building ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
(None, 'default1', None)
(None, None, 1)
('default1', 'default1', 1)
('default2', None, None)
*/

-- Prediction Query
SELECT name, street_address, floors FROM building ORDER BY floors, building.building_id NULLS LAST;

/*
Prediction Result:
(None, 'default1', None)
('default2', None, None)
('default1', 'default1', 1)
(None, None, 1)
*/