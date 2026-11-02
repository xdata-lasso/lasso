-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('professor', 'Cynthia Moore', '31712 Cantu Highway Suite 677
South Andrea, MS 25484', 'will', 1070, 1071);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('old', 'Jamie Cantu', '636 Louis Mountains
Hughesberg, NM 05353', 'card', 1073, 1074);
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('morning', 'professor', 'movie', '1870 Robert Shoal
North Terrance, KS 44876', 1991.0, 'Private', 1072, 'hair', 'go');
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('place', 'old', 'information', '46584 Justin Hills
Grimesmouth, ND 63984', 1991.0, 'Private', 1073, 'price', 'room');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "institution", "location" FROM "institution" WHERE ("type" = 'Private' AND founded > 1990.0) ORDER BY institution, institution.institution_id NULLS LAST;

/*
Gold Result:
('information', '46584 Justin Hills\nGrimesmouth, ND 63984')
('movie', '1870 Robert Shoal\nNorth Terrance, KS 44876')
*/

-- Prediction Query
SELECT institution, LOCATION FROM institution WHERE founded > 1990 AND TYPE = 'Private';

/*
Prediction Result:
('movie', '1870 Robert Shoal\nNorth Terrance, KS 44876')
('information', '46584 Justin Hills\nGrimesmouth, ND 63984')
*/