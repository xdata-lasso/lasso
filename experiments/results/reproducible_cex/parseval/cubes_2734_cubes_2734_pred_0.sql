-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: building --
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('bui_f1d5eb', 'bui_1e5126', '5k5swwqcgs', '9n8', 1, 21);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('C', 'bui_1e5126', '4', 'gu7v', 1, 21);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('A', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 1, 20);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('@', 'tti', 'bnp', 'mdpos', 1, NULL);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('_', 'ie5', 'nw6klf', 'a9000t5c4eci', 200, 21);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('?', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 200, 20);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('F', '2eutliqa11r', 'ytoo3o9', 'l7', 200, NULL);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('E', 'klex14ji', '7zwau2dwyr', '13pyu', NULL, 21);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('D', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', NULL, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM building WHERE (height_feet <> 200 AND floors > 20) ORDER BY name, building.building_id NULLS LAST;

/*
Gold Result:
('bui_1e5126',)
('bui_1e5126',)
*/

-- Prediction Query
SELECT name FROM building WHERE height_feet >= 200 AND floors >= 20;

/*
Prediction Result:
('ie5',)
('gce376nium52',)
*/