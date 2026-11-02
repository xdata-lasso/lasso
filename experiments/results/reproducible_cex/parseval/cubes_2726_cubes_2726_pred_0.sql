-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: building --
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('lhs_64bfc4', 'lhs_32c542', 'lhs_d6ac4f', 'lhs_996bae', 1, 20);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('lhs_be3fe3', 'lhs_5904c3', 'lhs_47d0c4', 'lhs_b0e65c', 1, 20);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('C', 'lhs_32c542', 'lhs_d6ac4f', 'lhs_996bae', 1, 20);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('A', '5k5swwqcgs', '9n8', '4', -734455130, 1744686505);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('Q', 'hria2ypu', 'hsrwbbp', 'luhvdltti', -1364429300, -1257178728);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('G', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('O', '4ecigce376n', 'um5', 'zbuo4nrq', 418417917, -1031969798);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('rhs_4081aa', 'lhs_32c542', 'lhs_d6ac4f', 'lhs_996bae', 1, 20);

-- Inserting into table: institution --
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('rhs_2c7f23', 'lhs_64bfc4', 'rhs_856484', 'rhs_ca23ff', 1.0, 'rhs_538022', 1, 'rhs_c95d9e', 'rhs_21c57d');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('rhs_5a60fb', 'lhs_64bfc4', 'rhs_95d8ee', 'rhs_f3ae27', 1.0, 'rhs_477a1a', 1, 'rhs_0c1fff', 'rhs_dbb742');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_3', 'rhs_4081aa', 'rhs_95d8ee', 'rhs_f3ae27', 1.0, 'rhs_477a1a', 1, 'rhs_0c1fff', 'rhs_dbb742');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_4', 'rhs_4081aa', 'rhs_95d8ee', 'rhs_f3ae27', 1.0, 'rhs_477a1a', 1, 'rhs_0c1fff', 'rhs_dbb742');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_5', 'rhs_4081aa', 'rhs_95d8ee', 'rhs_f3ae27', 1.0, 'rhs_477a1a', 1, 'rhs_0c1fff', 'rhs_dbb742');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('institutio_6', 'rhs_4081aa', 'rhs_95d8ee', 'rhs_f3ae27', 1.0, 'rhs_477a1a', 1, 'rhs_0c1fff', 'rhs_dbb742');

-- Inserting into table: protein --
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('rhs_ff1be2', 'rhs_2c7f23', 'rhs_fe5c1c', 1.0, 'rhs_6f1d50', 1.0, 'rhs_d7bb5e');

INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('rhs_3e5281', 'rhs_2c7f23', 'rhs_ba4698', 1.0, 'rhs_b9bf06', 1.0, 'rhs_b288df');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT floors) AS n_distinct FROM (SELECT * FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference FROM building AS LHS INNER JOIN institution AS RHS ON (LHS.building_id = RHS.building_id)) AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) WHERE (floors <= 20))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id JOIN building AS T3 ON T3.building_id = T1.building_id WHERE T3.floors >= 20;

/*
Prediction Result:
(2,)
*/