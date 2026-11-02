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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('stay', 'Jacob Hunter', 'similar', 'power');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('analysis', 'Samuel Short', 'nearly', 'system');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('hand', 'Tyler Reid', 'rather', 'wide');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('no', 'Michelle Graham', 'expect', 'nothing');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1033, 'stage', 'Marcusbury', 'court', 'Michigan', 'Alabama');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1034, 'member', 'West Nicolebury', 'method', 'Rhode Island', 'North Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1035, 'make', 'Hudsonfurt', 'difference', 'Vermont', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1036, 'least', 'Anthonymouth', 'hear', 'Oklahoma', 'Colorado');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('effort', 'Angela', 'Allen', 'fbrewer@example.com', 'scientist', 'enter', '651.382.3374', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('service', 'Angela', 'Allen', 'davisjeffrey@example.net', 'long', 'during', '643.252.4082', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('investment', 'Angela', 'Allen', 'kevinperkins@example.com', 'experience', 'camera', '9849271094', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('middle', 'Angela', 'Allen', 'ronald85@example.com', 'follow', 'set', '252.404.7116x719', 1033, 'stay');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('church', 'bed', NULL, 'south', 'Paper so difficult mission late kind.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('talk', 'energy', NULL, 'south', 'Wrong figure perform participant science way debate decision.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('order', 'by', NULL, 'south', 'Church community avoid able.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('fly', 'open', NULL, 'south', 'Ready like allow explain executive teacher author.', 'effort');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('Angela', 'Allen', 'south')
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.source FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE income.amount = (SELECT MAX(amount) FROM income);

/*
Prediction Result:
*/