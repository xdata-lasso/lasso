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
INSERT INTO POKER_PLAYER VALUES (-1, 0, 0, 0, 9, NULL);
INSERT INTO POKER_PLAYER VALUES (0, 0, 0, 0, 8, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM poker_player ORDER BY money_rank, poker_player.poker_player_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(8.0,)
*/

-- Prediction Query
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC, poker_player.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(8.0,)
*/