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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'maj_f6dbc3', '5k5swwqcgs', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', NULL, '9n8', 'maj_38581a');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_3', NULL, '4', 'maj_9da1e0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_4', NULL, 'gu7v', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_5', NULL, 'e4', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_6', NULL, 'hria2ypuzhs', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_7', NULL, 'rwbbp6luhvd', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'maj_f6dbc3', 'tti', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'maj_f6dbc3', 'bnp', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'mdpos', 'ie5', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'nw6klf', 'a9000t5c4eci', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'gce376nium52', 'zbuo4nrqrof', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('#', 'qyp5s5bbp0', '2eutliqa11r', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'ytoo3o9', 'l7', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'klex14ji', '7zwau2dwyr', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', '13pyu', '8d99rljsl', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'b4yp5qi', 'rkf9vqx5', 'College of Humanities and Social Sciences');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'pz0f8jegd', '1vy9uxj4', 'College of Humanities and Social Sciences');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(major_name) FROM major WHERE college = 'College of Humanities and Social Sciences';

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(major_id) FROM major WHERE college = 'College of Humanities and Social Sciences';

/*
Prediction Result:
(15,)
*/