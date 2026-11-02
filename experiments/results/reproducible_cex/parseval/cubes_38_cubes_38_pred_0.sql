-- Schema DDL
CREATE TABLE "i002" ("ID" INTEGER, "NAME" TEXT, "EMAIL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i002 --
INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_a53d09', 'i00_331c48');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'lhs_1c1506', 'lhs_3160db');

INSERT INTO "i002" ("id", "name", "email") VALUES (NULL, 'i00_a53d09', 'i00_331c48');

INSERT INTO "i002" ("id", "name", "email") VALUES (NULL, 'i00_825f19', 'i00_3e413e');

INSERT INTO "i002" ("id", "name", "email") VALUES (NULL, 'lhs_1c1506', 'lhs_3160db');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, NULL, 'i00_331c48');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, NULL, 'i00_3e413e');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'lhs_1c1506', 'lhs_3160db');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_a53d09', 'i00_001575');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_825f19', NULL);

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'lhs_1c1506', NULL);

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_a53d09', 'i00_331c48');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_825f19', 'i00_3e413e');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'lhs_1c1506', 'lhs_3160db');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_a53d09', 'i00_331c48');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'i00_825f19', 'i00_3e413e');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, 'lhs_1c1506', 'lhs_3160db');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, '5k5swwqcgs', '9n8');

INSERT INTO "i002" ("id", "name", "email") VALUES (1, '4', 'gu7v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.email AS email, RHS.id AS id_other, RHS.email AS email_other FROM i002 AS LHS INNER JOIN (SELECT id, name, email, COUNT(*) OVER () AS n FROM i002) AS RHS ON (LHS.id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME FROM (SELECT EMAIL, NAME, COUNT(*) AS n FROM i002 GROUP BY EMAIL, NAME) AS t WHERE n > 1.0;

/*
Prediction Result:
('i00_a53d09',)
('i00_825f19',)
('lhs_1c1506',)
*/