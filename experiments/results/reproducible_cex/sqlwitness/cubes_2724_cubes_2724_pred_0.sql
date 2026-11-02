-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO building (building_id, name, street_address, years_as_tallest, height_feet, floors) VALUES ('default1', NULL, NULL, 'default1', 1, 1), ('default2', NULL, NULL, 'default2', NULL, NULL), ('unique_2', NULL, 'default2', 'default1', NULL, 1), ('unique_3', 'default1', NULL, 'default2', 0, 1);
INSERT INTO institution (institution_id, building_id, institution, location, founded, type, enrollment, team, primary_conference) VALUES ('default1', NULL, 'default2', 'default2', NULL, 'default2', 1, 'default2', 'default1'), ('default2', 'unique_3', NULL, NULL, 1.0, 'default2', 1, 'default2', NULL), ('unique_2', NULL, 'default2', NULL, 1.0, 'default2', 1, NULL, 'default2'), ('unique_3', 'default2', NULL, 'default2', 1.0, 'default1', 1, 'default1', 'default2'), ('unique_4', 'unique_3', 'default2', NULL, 1.0, NULL, NULL, NULL, 'default1'), ('unique_5', 'unique_3', NULL, 'default2', 1.0, 'default2', NULL, NULL, 'default2'), ('unique_6', NULL, 'default1', NULL, 0.0, 'default2', 0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM institution ORDER BY TYPE;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT TYPE FROM institution;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/