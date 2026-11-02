-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO building (building_id, name, street_address, years_as_tallest, height_feet, floors) VALUES ('default1', 'default2', 'default1', NULL, 999, 999), ('default2', NULL, NULL, 'default2', NULL, NULL), ('unique_2', 'default1', 'default2', 'default2', 1990, 999);
INSERT INTO institution (institution_id, building_id, institution, location, founded, type, enrollment, team, primary_conference) VALUES ('default2', NULL, NULL, 'default2', 1.0, 'default2', 999, 'default1', NULL), ('default1', 'unique_2', NULL, 'default1', 1990.0, 'default1', 0, 'default1', NULL), ('unique_2', NULL, NULL, 'default2', 1990.0, 'default1', NULL, 'default1', 'default1'), ('unique_3', NULL, NULL, 'default2', 0.0, 'default1', 0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM institution WHERE (founded >= 1990.0 AND enrollment <> 1000) ORDER BY TYPE, institution.institution_id NULLS LAST;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT TYPE FROM institution WHERE founded > 1990 AND enrollment >= 1000;

/*
Prediction Result:
*/