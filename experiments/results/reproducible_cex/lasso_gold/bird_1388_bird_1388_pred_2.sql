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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('force', 'Angel Riggs', 'rise', 'traditional');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('down', 'Patricia Gibson', 'accept', 'speech');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('sure', 'Laura Higgins', 'walk', 'value');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('decide', 'James Hernandez', 'social', 'both');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('stay', 'Jacob Hunter', 'similar', 'power');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('analysis', 'Samuel Short', 'nearly', 'system');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('hand', 'Tyler Reid', 'rather', 'wide');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('no', 'Michelle Graham', 'expect', 'nothing');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('east', 'Leah Lara', 'thank', 'leg');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('window', 'Brian Walker', 'outside', 'capital');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('everything', 'Derek Thomas', 'will', 'management');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('store', 'Ricky Larson', 'fight', 'risk');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1025, 'start', 'Williamsbury', 'like', 'New Mexico', 'Kansas');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1026, 'large', 'South Dennismouth', 'watch', 'New Hampshire', 'South Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1027, 'discuss', 'Stephaniemouth', 'cold', 'Kentucky', 'Louisiana');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1028, 'control', 'Rivasside', 'six', 'Wisconsin', 'Wyoming');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1033, 'stage', 'Marcusbury', 'court', 'Michigan', 'Alabama');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1034, 'member', 'West Nicolebury', 'method', 'Rhode Island', 'North Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1035, 'make', 'Hudsonfurt', 'difference', 'Vermont', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1036, 'least', 'Anthonymouth', 'hear', 'Oklahoma', 'Colorado');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1041, 'scene', 'Kimton', 'part', 'Idaho', 'New York');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1042, 'interesting', 'Navarroview', 'amount', 'Tennessee', 'Minnesota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1043, 'yes', 'North Jeremyshire', 'source', 'Pennsylvania', 'Nebraska');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1044, 'expert', 'Port Emilyview', 'something', 'Nevada', 'Massachusetts');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('star', 'John', 'Gonzales', 'jimmy55@example.net', 'there', 'pattern', '001-596-670-5466x88937', 1025, 'force');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('near', 'John', 'Gonzales', 'taylorjesse@example.net', 'kitchen', 'young', '(270)365-6272x98069', 1025, 'force');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('memory', 'John', 'Gonzales', 'jasminebrown@example.com', 'improve', 'safe', '+1-862-672-0465x3755', 1025, 'force');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('produce', 'John', 'Gonzales', 'amy60@example.org', 'west', 'again', '001-564-217-0805x31003', 1025, 'force');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('effort', 'Angela', 'Allen', 'fbrewer@example.com', 'scientist', 'enter', '651.382.3374', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('service', 'Angela', 'Allen', 'davisjeffrey@example.net', 'long', 'during', '643.252.4082', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('investment', 'Angela', 'Allen', 'kevinperkins@example.com', 'experience', 'camera', '9849271094', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('middle', 'Angela', 'Allen', 'ronald85@example.com', 'follow', 'set', '252.404.7116x719', 1033, 'stay');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('religious', 'Angela', 'Allen', 'robert74@example.net', 'ability', 'maintain', '259.577.0348x24771', 1041, 'east');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('book', 'Angela', 'Allen', 'jcervantes@example.org', 'really', 'job', '001-424-980-8613x171', 1041, 'east');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('toward', 'Angela', 'Allen', 'qmiller@example.com', 'true', 'arm', '001-548-446-7737x826', 1041, 'east');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('college', 'Angela', 'Allen', 'cordovarichard@example.net', 'occur', 'cup', '946-458-4044', 1041, 'east');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('pretty', 'material', 1029, 'yourself', 'Let eight hard paper white.', 'star');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('claim', 'relationship', 1036.0, 'yourself', 'Sing clearly find official.', 'star');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('edge', 'building', 1043.0, 'yourself', 'Office traditional heart walk cup.', 'star');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('card', 'organization', 1050.0, 'yourself', 'Real physical big significant sure outside building worker.', 'star');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('church', 'bed', NULL, 'south', 'Paper so difficult mission late kind.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('talk', 'energy', NULL, 'south', 'Wrong figure perform participant science way debate decision.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('order', 'by', NULL, 'south', 'Church community avoid able.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('fly', 'open', NULL, 'south', 'Ready like allow explain executive teacher author.', 'effort');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('likely', 'of', 1045, 'south', 'Thank wonder draw him task improve.', 'religious');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('hair', 'huge', 1052.0, 'south', 'Seat relate specific history professional star.', 'religious');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('go', 'lose', 1059.0, 'south', 'Manager already maybe opportunity.', 'religious');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('old', 'worker', 1066.0, 'south', 'Them key moment lead.', 'religious');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('seven', 'material', NULL, 'yourself', 'Let eight hard paper white.', 'star');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('Angela', 'Allen', 'south')
*/

-- Prediction Query
SELECT "member"."first_name", "member"."last_name", "income"."source" FROM "member" INNER JOIN "income" ON "member"."member_id" = "income"."link_to_member" WHERE "income"."amount" = (SELECT MAX("amount") FROM "income" WHERE "income"."link_to_member" = "member"."member_id");

/*
Prediction Result:
('John', 'Gonzales', 'yourself')
('Angela', 'Allen', 'south')
*/