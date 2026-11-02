-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO building (building_id, name, street_address, years_as_tallest, height_feet, floors) VALUES ('Private', 'Private', 'default2', 'default1', NULL, NULL), ('default2', 'default1', NULL, 'default2', 1991, 1), ('default1', 'default2', 'default1', 'default1', NULL, 1991), ('unique_3', 'default2', 'Private', 'default2', 1, 1), ('unique_4', 'Private', NULL, 'default1', 1991, NULL), ('unique_5', 'Private', 'default2', NULL, 0, 1991), ('unique_6', 'default1', 'default2', NULL, 1, 1990), ('unique_7', 'default2', NULL, 'default2', 1, 1989), ('unique_8', 'default1', 'Private', 'default2', NULL, 0), ('unique_9', 'default1', 'default2', 'Private', 1991, 1), ('unique_10', NULL, 'default1', 'Private', 1990, 1989), ('unique_11', NULL, 'default1', NULL, NULL, 1990), ('unique_12', NULL, NULL, NULL, 1991, 1991), ('unique_13', 'Private', 'Private', 'default1', NULL, 1989), ('unique_14', 'default2', 'default2', 'default1', 1991, 1989), ('unique_15', 'default2', 'Private', 'Private', 1989, 1991), ('unique_16', NULL, NULL, NULL, 1991, 1), ('unique_17', NULL, 'default1', 'Private', 1991, 1989), ('unique_18', 'Private', 'default2', 'Private', NULL, NULL), ('unique_19', 'Private', 'Private', 'default1', NULL, NULL), ('unique_20', 'default1', 'default2', 'default1', NULL, 1);
INSERT INTO institution (institution_id, building_id, institution, location, founded, type, enrollment, team, primary_conference) VALUES ('default2', 'Private', NULL, 'Private', 1.0, NULL, 1990, NULL, 'Private'), ('default1', 'unique_20', 'Private', 'Private', NULL, 'Private', NULL, 'default1', 'default2'), ('Private', 'unique_12', 'default2', 'default1', 1.0, 'default1', 1, 'default2', NULL), ('unique_3', 'unique_8', NULL, NULL, 1.0, 'default2', NULL, 'default1', 'default1'), ('unique_4', 'unique_7', 'default2', 'default1', 1.0, 'Private', NULL, 'Private', 'default2'), ('unique_5', NULL, NULL, 'default2', 0.0, 'Private', 1, NULL, NULL), ('unique_6', 'Private', NULL, NULL, 0.0, 'default1', 0, 'default2', 'default2'), ('unique_7', 'unique_15', 'default1', NULL, 1991.0, 'Private', 0, 'Private', NULL), ('unique_8', 'unique_14', 'default2', 'default2', NULL, 'default2', NULL, NULL, NULL), ('unique_9', 'unique_6', 'default2', 'default2', 1989.0, 'default1', NULL, 'Private', 'Private'), ('unique_10', 'unique_11', 'Private', NULL, 1990.0, 'default2', 1989, 'default2', NULL), ('unique_11', 'unique_4', 'default2', 'default2', 1990.0, NULL, 1989, NULL, NULL), ('unique_12', NULL, 'default1', NULL, 1991.0, 'Private', 1990, 'default1', 'default2'), ('unique_13', 'unique_3', 'Private', NULL, 1991.0, 'Private', 1990, NULL, NULL), ('unique_14', 'unique_6', 'default2', NULL, 1991.0, 'Private', NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "institution", "location" FROM "institution" WHERE ("type" = 'Private' AND founded > 1990.0) ORDER BY institution, institution.institution_id NULLS LAST;

/*
Gold Result:
('Private', None)
('default1', None)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT institution, LOCATION FROM institution WHERE founded > 1990 AND TYPE = 'Private';

/*
Prediction Result:
('default1', None)
('default1', None)
('Private', None)
('default2', None)
*/