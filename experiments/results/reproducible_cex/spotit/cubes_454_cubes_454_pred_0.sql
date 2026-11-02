-- Schema DDL
CREATE TABLE "POKER_PLAYER" (
    "POKER_PLAYER_ID" INT,
    "PEOPLE_ID" INT,
    "FINAL_TABLE_MADE" FLOAT,
    "BEST_FINISH" FLOAT,
    "MONEY_RANK" FLOAT,
    "EARNINGS" FLOAT,
    PRIMARY KEY ("POKER_PLAYER_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NATIONALITY" TEXT,
    "NAME" TEXT,
    "BIRTH_DATE" TEXT,
    "HEIGHT" FLOAT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO POKER_PLAYER VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO POKER_PLAYER VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM poker_player);

/*
Prediction Result:
('0',)
*/