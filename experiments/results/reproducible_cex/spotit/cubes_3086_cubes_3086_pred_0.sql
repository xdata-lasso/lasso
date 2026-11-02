-- Schema DDL
CREATE TABLE "MOUNTAIN" (
    "ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "PROMINENCE" FLOAT,
    "RANGE" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "CAMERA_LENS" (
    "ID" INT,
    "BRAND" TEXT,
    "NAME" TEXT,
    "FOCAL_LENGTH_MM" FLOAT,
    "MAX_APERTURE" FLOAT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "PHOTOS" (
    "ID" INT,
    "MOUNTAIN_ID" INT,
    "CAMERA_LENS_ID" INT,
    "COLOR" TEXT,
    "NAME" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("MOUNTAIN_ID") REFERENCES "MOUNTAIN"("ID"),
    FOREIGN KEY ("CAMERA_LENS_ID") REFERENCES "CAMERA_LENS"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MOUNTAIN VALUES (1, 19, 20, 21, 22, 23);
INSERT INTO MOUNTAIN VALUES (0, 0, 4000, 26, 27, 28);
INSERT INTO CAMERA_LENS VALUES (-1, 0, 0, 0, 0);
INSERT INTO CAMERA_LENS VALUES (0, 0, 0, 0, 0);
INSERT INTO PHOTOS VALUES (-1, 0, 0, 24, 25);
INSERT INTO PHOTOS VALUES (0, 0, 0, 29, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM (SELECT id, name, height, prominence, RANGE, country, id_other, camera_lens_id, color, name_other, id AS mountain_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.id AS id_other, RHS.camera_lens_id AS camera_lens_id, RHS.color AS color, RHS.name AS name_other FROM mountain AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.mountain_id))) WHERE (height >= 4000.0) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(0, '0')
(0, '0')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.height > 4000;

/*
Prediction Result:
*/