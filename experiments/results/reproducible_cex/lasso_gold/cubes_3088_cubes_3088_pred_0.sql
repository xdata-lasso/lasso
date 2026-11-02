-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1234, 'Sigma', 'Crystal Johnson', 1236.5, 1238.5);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1235, 'Olympus', 'Danielle Moore', 1245.5, 1249.5);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1244, 'Sigma', 'Cassandra Estes', 1237.5, 1239.5);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1245, 'Olympus', 'Garrett Lin', 1255.5, 1259.5);
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1240, 'Janet Williams', 1241.5, 1242.5, 'many', 'Cyprus');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1250, 'Diana May', 1251.5, 1252.5, 'instead', 'Philippines');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1243, 1240, 1234, 'decision', 'Julia Torres');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1253, 1250, 1244, 'threat', 'Teresa Wilson');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."id" AS "id_other", "RHS"."mountain_id" AS "mountain_id", "RHS"."color" AS "color", "RHS"."name" AS "name_other" FROM (SELECT * FROM "camera_lens" WHERE ("brand" = 'Sigma' OR "brand" = 'Olympus')) AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Cassandra Estes',)
('Crystal Johnson',)
*/

-- Prediction Query
SELECT T1.name FROM camera_lens AS T1 JOIN photos AS T2 ON T2.camera_lens_id = T1.id WHERE T1.brand = 'Sigma' OR T1.brand = 'Olympus';

/*
Prediction Result:
('Crystal Johnson',)
('Cassandra Estes',)
*/