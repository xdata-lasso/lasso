-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('determine', 'Thomas Miller', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'drop', 1005, 1006);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('not', 'Renee Morales', '327 Nelson Route
Lake Mark, WI 07832', 'hear', 1006, 1007);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, street_address, floors FROM building ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832', 1007)
('Thomas Miller', '310 Kendra Common Apt. 164\nReidstad, GA 49021', 1006)
*/

-- Prediction Query
SELECT name, street_address, floors FROM building ORDER BY floors, building.building_id NULLS LAST;

/*
Prediction Result:
('Thomas Miller', '310 Kendra Common Apt. 164\nReidstad, GA 49021', 1006)
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832', 1007)
*/