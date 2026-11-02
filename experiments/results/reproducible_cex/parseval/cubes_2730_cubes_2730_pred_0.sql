-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: building --
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('ins_bc5844', '5k5swwqcgs', '9n8', '4', -734455130, 1744686505);

INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('lhs_07c9b8', 'ytoo3o9', 'l7', 'klex14ji', -453362185, 481163439);

-- Inserting into table: institution --
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('ins_32ac38', 'ins_bc5844', 'hria2ypu', 'hsrwbbp', 503.083789, 'hvdltt', -1610064545, 'n', 'ins_92c8d9');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('ins_700bea', 'ins_bc5844', 'rmdp', 'siie', 489.397796, 'w6kl', 1620389964, '00t5c4ecigc', 'ins_92c8d9');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('ins_15dccc', 'ins_bc5844', 'e376nium52', 'zbuo4nrqrof', 586.906897, 'p5s5bbp', 882961052, '2eutliqa11r', 'ins_92c8d9');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('lhs_b081f2', 'lhs_07c9b8', 'lhs_51f4e3', 'lhs_a2f8b7', 1.0, 'lhs_08a16b', 1, 'lhs_74c99f', 'lhs_b8f63a');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('A', 'lhs_07c9b8', 'lhs_51f4e3', 'lhs_a2f8b7', 1.0, 'lhs_08a16b', 1, 'lhs_74c99f', 'lhs_b8f63a');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('C', 'lhs_07c9b8', '2dwyrq13pyu7', 'd99rljsl0', 27.036693, 'p5qi2rk', -705985602, 'x58pz0f8je', 'd2');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('Q', 'lhs_07c9b8', 'lhs_51f4e3', 'lhs_a2f8b7', 1.0, 'lhs_08a16b', 1, 'lhs_74c99f', 'lhs_b8f63a');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('O', 'lhs_07c9b8', 'lhs_51f4e3', 'lhs_a2f8b7', 1.0, 'lhs_08a16b', 1, 'lhs_74c99f', 'lhs_b8f63a');

INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('rhs_43d40e', 'lhs_07c9b8', 'lhs_51f4e3', 'lhs_a2f8b7', 1.0, 'lhs_08a16b', 1, 'lhs_74c99f', 'lhs_b8f63a');

-- Inserting into table: protein --
INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('rhs_f5b0ea', 'lhs_b081f2', 'rhs_ddca51', 1.0, 'rhs_6011e8', 1.0, 'rhs_e6cfb2');

INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('G', 'rhs_43d40e', 'rhs_ddca51', 1.0, 'rhs_6011e8', 1.0, 'rhs_e6cfb2');

INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('A', 'rhs_43d40e', 'rhs_6596e2', 1.0, 'rhs_0456de', 1.0, 'rhs_075744');

INSERT INTO "protein" ("common_name", "institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('I', 'rhs_43d40e', 'rhs_ddca51', 1.0, 'rhs_6011e8', 1.0, 'rhs_e6cfb2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT institution, n AS count___ FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, RHS.n AS n FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM institution AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) AS LHS INNER JOIN (SELECT building_id, primary_conference, COUNT(*) AS n FROM institution GROUP BY building_id, primary_conference) AS RHS ON (LHS.primary_conference = RHS.primary_conference AND LHS.building_id = RHS.building_id)) ORDER BY institution, count___ NULLS LAST;

/*
Gold Result:
('lhs_51f4e3', 5)
*/

-- Prediction Query
SELECT T1.institution, COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id GROUP BY T1.institution_id;

/*
Prediction Result:
('lhs_51f4e3', 1)
('lhs_51f4e3', 3)
*/