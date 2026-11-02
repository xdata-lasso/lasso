-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: building --
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('building_i_1', '5k5swwqcgs', '9n8', '4', -734455130, 1744686505);

-- Inserting into table: institution --
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('ins_dd647a', 'building_i_1', 'hria2ypu', 'hsrwbbp', 1990.0, 'ins_aff0d8', 1, 'luhvdltti', 'bnp');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('C', 'building_i_1', 'dposiie5unw', 'klfa9000t', 1990.0, 'ins_aff0d8', 1, 'c4ecigce', '76nium52');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('A', 'building_i_1', 'nrqrofqy', '5s5b', 1990.0, 'p', 1000, '02eutliqa11r', 'ytoo3o9');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('@', 'building_i_1', '72k', 'ex1', 1990.0, 'ji7zwau2', NULL, 'dwyrq13pyu78', '9');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('?', 'building_i_1', 'jsl', 'b4yp5qi', 1989.99, 'rkf9vqx5', 1, 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('G', 'building_i_1', 'bdvlph', 'gndqwnqc', 1989.99, 'x5hncprjtu0', 1000, 'z', '9fjgq8n2f');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('E', 'building_i_1', 'dqv0gcb98ozk', 'zbilyrkn', 1989.99, '6vck6ah0f8js', NULL, 'wlq7xb', '72fxa7ryfd');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('`', 'building_i_1', 'z16nijjai5d', 'h5ogrgjd8yz', NULL, '1afgo', 1, 'ri', 'tsj3ayxp1q4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM institution WHERE (founded >= 1990.0 AND enrollment <> 1000) ORDER BY TYPE, institution.institution_id NULLS LAST;

/*
Gold Result:
('ins_aff0d8',)
('ins_aff0d8',)
*/

-- Prediction Query
SELECT TYPE FROM institution WHERE founded > 1990 AND enrollment >= 1000;

/*
Prediction Result:
*/