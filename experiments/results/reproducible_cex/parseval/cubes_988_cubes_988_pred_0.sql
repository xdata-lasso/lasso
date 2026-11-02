-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: track --
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1, 'tra_353016', '5k5swwqcgs', 1.0, 2000.0);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (3, 'tra_353016', '9n8', 1.0, 2000.0);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (2, '4', 'gu7v', 86.520366, 1999.99);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (4, '4h', 'ia2yp', 718.397869, NULL);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (5, NULL, 'zhsrwb', 994.117864, 2000.0);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (6, 'p6luhvdlttil', 'n', NULL, 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
(None, 994.117864)
('p6luhvdlttil', None)
('tra_353016', 1.0)
('tra_353016', 1.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
*/