-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('17', NULL, '18', '19', 797, 20);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('9', NULL, '797', '797', -635, 797);
INSERT INTO "Institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('11', '9', '797', '797', 797, '797', 797, '797', '797');
INSERT INTO "Institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('10', '9', '797', '797', 797, '797', 797, '797', '797');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('13', '10', '797', 797, '797', 797, '797');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('12', '10', '797', 797, '797', 797, '797');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors FROM building AS LHS INNER JOIN (SELECT MAX(height_feet) AS maxheight_feet FROM building) AS RHS ON (LHS.height_feet = RHS.maxheight_feet)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM building ORDER BY height_feet DESC, building.building_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/