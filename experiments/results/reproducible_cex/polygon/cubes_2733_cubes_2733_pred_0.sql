-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('9', '12', '12', '12', 12, 12);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('12', '12', '12', '12', 12, 12);
INSERT INTO "Institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('11', '12', '15', '16', 1991, NULL, 1001, '17', '18');
INSERT INTO "Institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('10', '12', '19', '20', 1991, NULL, 1000, '21', '22');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('14', '10', '12', 12, '12', 12, '12');
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('13', '10', '12', 12, '12', 12, '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM institution WHERE (founded >= 1990.0 AND enrollment <> 1000) ORDER BY TYPE, institution.institution_id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT TYPE FROM institution WHERE founded > 1990 AND enrollment >= 1000;

/*
Prediction Result:
(None,)
(None,)
*/