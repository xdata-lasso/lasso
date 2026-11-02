-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1, 'lhs_7c888e', 4000.0, 1.0, 'lhs_ba26d5', 'lhs_ff2d5e');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'lhs_31b3dc', 4000.0, 1.0, 'lhs_4e5ba3', 'lhs_5aa165');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (3, 'lhs_7c888e', 4000.0, 1.0, 'lhs_ba26d5', 'lhs_ff2d5e');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (4, 'p6luhvdlttil', 22.535764, 600.048938, 'rmdp', 'siie');

-- Inserting into table: camera_lens --
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (-2147483648, '5sw', 'qcgsk9', 206.939346, 604.777832);

INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'gu7v', 'e4', 779.409124, 640.719621);

-- Inserting into table: photos --
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1, 1, -2147483648, '4', 'pho_a53e8c');

INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (-2147483647, 1, -2147483648, 'ypuzhsrw', 'pho_c92d1a');

INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (2, 1, 1, 'rhs_1f4e47', 'rhs_556beb');

INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (3, 1, 1, 'rhs_a23b29', 'rhs_a075c3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM (SELECT id, name, height, prominence, RANGE, country, id_other, camera_lens_id, color, name_other, id AS mountain_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.id AS id_other, RHS.camera_lens_id AS camera_lens_id, RHS.color AS color, RHS.name AS name_other FROM mountain AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.mountain_id))) WHERE (height >= 4000.0) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(1, 'lhs_7c888e')
(1, 'lhs_7c888e')
(1, 'lhs_7c888e')
(1, 'lhs_7c888e')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.height > 4000;

/*
Prediction Result:
*/