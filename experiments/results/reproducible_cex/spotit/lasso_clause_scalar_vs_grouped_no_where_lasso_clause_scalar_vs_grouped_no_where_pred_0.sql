-- Schema DDL
CREATE TABLE "MEMBER" (
    "MEMBER_ID" TEXT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    PRIMARY KEY ("MEMBER_ID")
);
CREATE TABLE "EXPENSE" (
    "EXPENSE_ID" TEXT,
    "COST" FLOAT,
    "LINK_TO_MEMBER" TEXT,
    PRIMARY KEY ("EXPENSE_ID"),
    FOREIGN KEY ("LINK_TO_MEMBER") REFERENCES "MEMBER"("MEMBER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MEMBER VALUES (7, 8, 9);
INSERT INTO MEMBER VALUES (4, NULL, NULL);
INSERT INTO EXPENSE VALUES (5, 1, 7);
INSERT INTO EXPENSE VALUES (6, 5853, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, SUM(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member;

/*
Gold Result:
('8', '9', 5854.0)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, SUM(expense.cost) AS total_cost FROM member INNER JOIN expense ON member.member_id = expense.link_to_member GROUP BY member.first_name, member.last_name;

/*
Prediction Result:
(None, None, 5853.0)
('8', '9', 1.0)
*/