-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('four', 'Austin Gentry', '76724 John Points Suite 969
Coxberg, NY 65187', 'benefit', 1009, 1010);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('rest', 'Nicole Mack', '2704 William Coves Suite 893
West Kathryn, ND 70015', 'why', 1013, 1014);
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('a', 'four', 'anyone', '269 Paul Ranch
Riceside, VI 02005', 1011.5, 'response', 1012, 'set', 'building');
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('someone', 'rest', 'place', '54303 Christopher Oval
Port Amandaberg, DC 86975', 1012.5, 'company', 1013, 'your', 'often');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM institution ORDER BY TYPE;

/*
Gold Result:
('company',)
('response',)
*/

-- Prediction Query
SELECT DISTINCT TYPE FROM institution;

/*
Prediction Result:
('response',)
('company',)
*/