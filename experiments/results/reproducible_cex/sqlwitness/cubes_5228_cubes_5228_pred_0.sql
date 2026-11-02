-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO building (building_id, name, street_address, years_as_tallest, height_feet, floors) VALUES ('default1', 'default1', NULL, 'default2', NULL, 0), ('default2', 'default2', 'default2', 'default2', 1, NULL), ('unique_2', 'default1', NULL, 'default1', 1, 1), ('unique_3', NULL, 'default1', 'default2', NULL, 0), ('unique_4', 'default1', 'default2', NULL, 0, 1), ('unique_5', NULL, 'default1', 'default2', NULL, 0), ('unique_6', 'default1', 'default1', 'default1', 0, 1);
INSERT INTO institution (institution_id, building_id, institution, location, founded, type, enrollment, team, primary_conference) VALUES ('default2', 'unique_5', 'default2', 'default1', NULL, NULL, NULL, 'default1', 'default1'), ('default1', 'default2', 'default1', NULL, 1.0, 'default2', 0, 'default2', 'default2'), ('unique_2', 'unique_6', NULL, NULL, 1.0, 'default1', 0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.n AS n FROM building AS LHS INNER JOIN (SELECT building_id, COUNT(*) AS n FROM institution GROUP BY building_id) AS RHS ON (LHS.building_id = RHS.building_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('default1', 1)
('default2', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id GROUP BY T1.building_id;

/*
Prediction Result:
('default2', 1)
(None, 1)
('default1', 1)
*/