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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Katy17', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('rec1N0upiVLy5esTO16', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('rec1N0upiVLy5esTO', 'Katy41', 'rec1N0upiVLy5esTO42', NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Katy31', 'rec1N0upiVLy5esTO32', 'Katy33', NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (35, 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Katy17', 'rec1N0upiVLy5esTO34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('rec1N0upiVLy5esTO16', 'rec1N0upiVLy5esTO34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('rec1N0upiVLy5esTO18', 'rec1N0upiVLy5esTO16', 'rec1N0upiVLy5esTO34', 34, 34, 34, 'rec1N0upiVLy5esTO34');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO18', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 34, 'rec1N0upiVLy5esTO34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('rec1N0upiVLy5esTO20', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 34, 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Katy19', 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34', 34, 'rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Katy25', 'Katy31', 35, 'Katy', 'rec1N0upiVLy5esTO26', 'Katy27', 'rec1N0upiVLy5esTO28', 'Katy29', 'rec1N0upiVLy5esTO30');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('rec1N0upiVLy5esTO34', 'rec1N0upiVLy5esTO', 35, 'Katy', 'rec1N0upiVLy5esTO36', 'Katy37', 'rec1N0upiVLy5esTO38', 'Katy39', 'rec1N0upiVLy5esTO40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.link_to_major = 'rec1N0upiVLy5esTO' AND T1.first_name = 'Katy';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Katy';

/*
Prediction Result:
(None,)
(None,)
*/