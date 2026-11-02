-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Empire', '123 St', '1931', 1000, 100);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Inst1', 'NY', 2005.0, 'Public', 1000, 'T1', 'C1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM building AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM institution WHERE (founded >= 2003.0)) AS RHS WHERE (LHS.building_id = RHS.building_id))) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM building EXCEPT SELECT T1.name FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id WHERE T2.founded = 2003;

/*
Prediction Result:
('Empire',)
*/