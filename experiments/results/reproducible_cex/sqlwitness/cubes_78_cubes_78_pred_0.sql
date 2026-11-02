-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO visitor (id, name, level_of_membership, age) VALUES (0, 'default2', 1, NULL), (1, NULL, 2, 1);
INSERT INTO museum (museum_id, name, num_of_staff, open_year) VALUES (2, NULL, NULL, 'default2'), (1, NULL, 2, NULL), (0, 'default2', 1, 'default2'), (3, NULL, 2, 'default2'), (4, NULL, 1, NULL);
INSERT INTO visit (museum_id, visitor_id, num_of_ticket, total_spent) VALUES (4, 1, NULL, 0.0), (1, 0, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM museum AS LHS WHERE NOT EXISTS(SELECT 1 FROM visit AS RHS WHERE (LHS.museum_id = RHS.museum_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT name FROM museum WHERE NOT Museum_ID IN (SELECT museum_id FROM visit);

/*
Prediction Result:
('default2',)
(None,)
(None,)
*/