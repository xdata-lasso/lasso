-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Central Tower', '10 First Ave', '1970-1980', 600, 50);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B2', 'Central Tower', '20 Second Ave', '1980-1990', 700, 60);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B3', 'Annex Hall', '30 Third Ave', '1960-1970', 200, 15);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Inst 1', 'Loc 1', 1900.0, 'Public', 1000, 'Hawks', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B1', 'Inst 2', 'Loc 1', 1910.0, 'Private', 2000, 'Eagles', 'East');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B1', 'Inst 3', 'Loc 1', 1920.0, 'Public', 1500, 'Falcons', 'West');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I4', 'B2', 'Inst 4', 'Loc 2', 1930.0, 'Private', 500, 'Owls', 'North');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I5', 'B3', 'Inst 5', 'Loc 3', 1940.0, 'Public', 4000, 'Wolves', 'South');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I6', 'B3', 'Inst 6', 'Loc 3', 1950.0, 'Private', 3500, 'Foxes', 'South');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.n AS n FROM building AS LHS INNER JOIN (SELECT building_id, COUNT(*) AS n FROM institution GROUP BY building_id) AS RHS ON (LHS.building_id = RHS.building_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Annex Hall', 2)
('Central Tower', 1)
('Central Tower', 3)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id GROUP BY T1.building_id;

/*
Prediction Result:
('Central Tower', 3)
('Central Tower', 1)
('Annex Hall', 2)
*/