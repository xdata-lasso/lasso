-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "Name") VALUES ('b1', 'Building 1');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Primary_Conference") VALUES ('i1', 'b1', 'Inst A', 'Conf 1');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name") VALUES ('p1', 'i1', 'Prot 1');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name") VALUES ('p2', 'i1', 'Prot 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT institution, n AS count___ FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, RHS.n AS n FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM institution AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) AS LHS INNER JOIN (SELECT building_id, primary_conference, COUNT(*) AS n FROM institution GROUP BY building_id, primary_conference) AS RHS ON (LHS.primary_conference = RHS.primary_conference AND LHS.building_id = RHS.building_id)) ORDER BY institution, count___ NULLS LAST;

/*
Gold Result:
('Inst A', 1)
*/

-- Prediction Query
SELECT T1.institution, COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id GROUP BY T1.institution_id;

/*
Prediction Result:
('Inst A', 2)
*/