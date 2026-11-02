-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: campuses --
INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (1, 'cam_ed147e', '5k5swwqcgs', '9n8', 1936);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483647, 'cam_ed147e', '4', 'gu7v', 1936);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (2, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 1939);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (3, '5k5swwqcgs', '9n8', '4', 1935);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (4, '5k5swwqcgs', '9n8', '4', NULL);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (5, 'gu7v', 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (6, 'rwbbp6luhvd', 'tti', 'bnp', NULL);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (7, 'mdpos', 'ie5', 'nw6klf', NULL);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (8, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', NULL);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (9, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR > 1935 AND YEAR < 1939) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('cam_ed147e',)
('cam_ed147e',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR >= 1935 AND YEAR <= 1939;

/*
Prediction Result:
('cam_ed147e',)
('cam_ed147e',)
('e4',)
('5k5swwqcgs',)
*/