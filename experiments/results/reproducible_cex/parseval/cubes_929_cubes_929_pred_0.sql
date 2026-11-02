-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 582.588439);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483647, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 680.190136);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483646, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 487.053947);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483645, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 486.033807);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483644, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 345.329712);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (2, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 833.684115);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (3, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 261.897639);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (4, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 97.952323);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483640, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 171.746906);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483639, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 557.512061);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483638, 'q_2_048c35', 'man_723ac8', 'man_f2e07d', 868.436572);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (5, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 537.136345);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (6, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 38.937207);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (7, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 249.706432);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('q_2_048c35',)
('man_8257fe',)
('man_8257fe',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
('man_8257fe',)
('q_2_048c35',)
('q_2_048c35',)
('q_2_048c35',)
('q_2_048c35',)
('man_8257fe',)
('man_8257fe',)
('man_8257fe',)
*/