-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483648, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483647, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483646, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483645, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483644, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483643, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483642, NULL, 'man_723ac8', 'man_f2e07d', 582.588439);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483641, NULL, 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483640, NULL, 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483639, NULL, 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483638, 'man_8257fe', NULL, 'man_f2e07d', 680.190136);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483637, 'man_8fd0e6', NULL, 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483636, 'man_8fd0e6', NULL, 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483635, 'man_8fd0e6', NULL, 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483634, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483633, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483632, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483631, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483630, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483629, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483628, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483627, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483626, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483625, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483624, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483623, 'man_8fd0e6', 'man_bf2c06', 'man_f2e07d', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, revenue AS max_revenue_, headquarter FROM (SELECT headquarter, name, MAX(revenue) AS revenue FROM manufacturers GROUP BY headquarter, name) ORDER BY name, max_revenue_ NULLS LAST, headquarter NULLS LAST;

/*
Gold Result:
(None, 1.0, 'man_bf2c06')
(None, 582.588439, 'man_723ac8')
('man_8257fe', 680.190136, None)
('man_8fd0e6', 1.0, 'man_bf2c06')
('man_8fd0e6', 1.0, None)
*/

-- Prediction Query
SELECT name, MAX(revenue), Headquarter FROM manufacturers GROUP BY Headquarter;

/*
Prediction Result:
('man_8257fe', 680.190136, None)
(None, 582.588439, 'man_723ac8')
('man_8fd0e6', 1.0, 'man_bf2c06')
*/