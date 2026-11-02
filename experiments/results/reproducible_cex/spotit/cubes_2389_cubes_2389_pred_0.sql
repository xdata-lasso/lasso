-- Schema DDL
CREATE TABLE "MOUNTAIN" (
    "MOUNTAIN_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "PROMINENCE" FLOAT,
    "RANGE" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("MOUNTAIN_ID")
);
CREATE TABLE "CLIMBER" (
    "CLIMBER_ID" INT,
    "MOUNTAIN_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "TIME" TEXT,
    "POINTS" FLOAT,
    PRIMARY KEY ("CLIMBER_ID"),
    FOREIGN KEY ("MOUNTAIN_ID") REFERENCES "MOUNTAIN"("MOUNTAIN_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MOUNTAIN VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO MOUNTAIN VALUES (0, -1, 0, 0, 0, 0);
INSERT INTO CLIMBER VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO CLIMBER VALUES (1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM mountain AS LHS WHERE NOT EXISTS(SELECT 1 FROM climber AS RHS WHERE (LHS.mountain_id = RHS.mountain_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE NOT Mountain_ID IN (SELECT Mountain_ID FROM climber);

/*
Prediction Result:
('0',)
*/