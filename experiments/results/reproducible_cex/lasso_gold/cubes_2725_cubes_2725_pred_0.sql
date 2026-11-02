-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('purpose', 'Daniel Doyle', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 'forward', 1001, 1005);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('brother', 'Stephanie Miller', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'difference', 1012.0, 1018.0);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('ago', 'Allen Robinson', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'reality', 1023.0, 1031.0);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('site', 'Alyssa Gonzalez', '503 Linda Locks
Carlshire, FM 94599', 'money', 1034.0, 1044.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM building ORDER BY years_as_tallest DESC, building.building_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Allen Robinson',)
*/

-- Prediction Query
SELECT name FROM building ORDER BY height_feet DESC, building.building_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alyssa Gonzalez',)
*/