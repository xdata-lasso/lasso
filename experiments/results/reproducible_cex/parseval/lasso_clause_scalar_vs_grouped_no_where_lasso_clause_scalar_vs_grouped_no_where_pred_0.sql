-- Schema DDL
CREATE TABLE member (member_id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT);

CREATE TABLE expense (expense_id TEXT PRIMARY KEY, cost REAL, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('t1__9408f5', 't1__aa5b58', 't1__859b7d');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('A', 't1__aa5b58', 't1__859b7d');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('C', 't1__aa5b58', 't1__859b7d');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('_', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('O', '4h', 'ia2yp');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('Q', 'zhsrwb', 'p');

INSERT INTO "member" ("member_id", "first_name", "last_name") VALUES ('t2__3ad7f8', 't1__aa5b58', 't1__859b7d');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_1', 582.588439, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_2', 680.190136, 'A');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_3', 487.053947, 'A');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_4', 86.520366, '_');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_5', 718.397869, 'O');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_id_6', 503.083789, 'Q');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('_', 320.851235, 't2__3ad7f8');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('A', 113.643485, 't2__3ad7f8');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('O', 855.355181, 't2__3ad7f8');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_10', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_11', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_12', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_13', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_14', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_15', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_16', NULL, 't1__9408f5');

INSERT INTO "expense" ("expense_id", "cost", "link_to_member") VALUES ('expense_i_17', NULL, 't1__9408f5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, SUM(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member;

/*
Gold Result:
('t1__aa5b58', 't1__859b7d', 4347.684447000001)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, SUM(expense.cost) AS total_cost FROM member INNER JOIN expense ON member.member_id = expense.link_to_member GROUP BY member.first_name, member.last_name;

/*
Prediction Result:
('4h', 'ia2yp', 718.397869)
('swwqcgsk', '9n8c4pgu7v', 86.520366)
('t1__aa5b58', 't1__859b7d', 3039.682423)
('zhsrwb', 'p', 503.083789)
*/