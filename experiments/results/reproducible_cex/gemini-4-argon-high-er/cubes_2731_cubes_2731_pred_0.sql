-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('b1', 'Main Hall', '123 St', '2000-2010', 100, 10);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('2', 'b1', 'Zeta University', 'City B', 2000.0, 'Private', 5000, 'Lions', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('1', 'b1', 'Alpha University', 'City A', 2005.0, 'Private', 3000, 'Tigers', 'Conf B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "institution", "location" FROM "institution" WHERE ("type" = 'Private' AND founded > 1990.0) ORDER BY institution, institution.institution_id NULLS LAST;

/*
Gold Result:
('Alpha University', 'City A')
('Zeta University', 'City B')
*/

-- Prediction Query
SELECT institution, LOCATION FROM institution WHERE founded > 1990 AND TYPE = 'Private';

/*
Prediction Result:
('Zeta University', 'City B')
('Alpha University', 'City A')
*/