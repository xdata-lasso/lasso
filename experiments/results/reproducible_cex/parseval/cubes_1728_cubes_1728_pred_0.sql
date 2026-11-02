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
INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483648, 'cam_431af7', 'Northridge', 'Los Angeles', -55602865);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483647, 'cam_e775a2', 'San Francisco', 'San Francisco', -59984348);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (2, 'cam_431af7', 'Northridge', 'Los Angeles', -664303813);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (3, 'cam_431af7', 'Northridge', 'Los Angeles', -1022641847);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483646, 'cam_e775a2', 'San Francisco', 'San Francisco', -1726781632);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483643, 'cam_ed8c3b', 'San Francisco', 'San Francisco', 247012447);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483642, 'cam_431af7', 'Northridge', 'Los Angeles', -1980249628);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483641, 'cam_2dec05', 'Northridge', 'Los Angeles', -734455130);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483640, 'cam_431af7', 'cam_bde12c', 'Los Angeles', 1744686505);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483639, 'cam_e775a2', 'San Francisco', 'San Francisco', -1633151678);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483638, 'cam_431af7', 'Northridge', 'cam_ad3b24', -252690330);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483637, 'cam_e775a2', 'San Francisco', 'San Francisco', 1115440883);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483636, 'cam_431af7', 'Northridge', 'Los Angeles', 1644814318);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483635, 'cam_e775a2', 'cam_fe16fa', 'San Francisco', 1465859724);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483634, 'cam_431af7', 'Northridge', 'Los Angeles', -1349201381);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483633, 'cam_e775a2', 'San Francisco', 'cam_aed1f7', 1019800248);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483632, NULL, 'Northridge', 'Los Angeles', -1910425938);

INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (-2147483631, NULL, 'San Francisco', 'San Francisco', -845863578);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM (SELECT * FROM "campuses" WHERE ("county" = 'Los Angeles' OR "county" = 'San Francisco')) WHERE ("location" = 'Northridge' OR "location" = 'San Francisco') ORDER BY campus, "campus" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('cam_2dec05',)
('cam_431af7',)
('cam_431af7',)
('cam_431af7',)
('cam_431af7',)
('cam_431af7',)
('cam_431af7',)
('cam_e775a2',)
('cam_e775a2',)
('cam_e775a2',)
('cam_e775a2',)
('cam_ed8c3b',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Northridge' AND county = 'Los Angeles' UNION SELECT campus FROM campuses WHERE LOCATION = 'San Francisco' AND county = 'San Francisco';

/*
Prediction Result:
(None,)
('cam_2dec05',)
('cam_431af7',)
('cam_e775a2',)
('cam_ed8c3b',)
*/