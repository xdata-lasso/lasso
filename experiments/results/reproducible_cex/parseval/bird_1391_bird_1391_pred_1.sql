-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'Finance', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'Physics', '4', 'gu7v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_3', 'Finance', 'e4', 'hria2ypuzhs');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_4', 'maj_2f9865', 'rwbbp6luhvd', 'tti');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_5', 'maj_2f9865', 'bnp', 'mdpos');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_6', 'maj_2f9865', 'ie5', 'nw6klf');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'Finance', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'Physics', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'Finance', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'Finance', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'Finance', '7zwau2dwyr', '13pyu');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 'Finance', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 'Finance', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', 'Finance', '1vy9uxj4', 'wb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'Finance', 'v', 'ph2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'Finance', 'nd', 'wnqcx');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT CAST(SUM(major_name = 'Finance') AS REAL) / SUM(major_name = 'Physics') AS ratio FROM major INNER JOIN member ON major.major_id = member.link_to_major;

/*
Prediction Result:
(None,)
*/