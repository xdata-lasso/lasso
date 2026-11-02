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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('data', 'Tracy Ramirez', 'evidence', 'leader');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('inside', 'Jennifer Zavala', 'American', 'hair');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('get', 'Teresa Wilson', 'boy', 'shoulder');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('family', 'Cassandra Estes', 'pick', 'stop');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('front', 'David Benson', 'safe', 'southern');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('walk', 'Amy Russell', 'again', 'parent');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('now', 'Jennifer Clark', 'tough', 'husband');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('be', 'Taylor Silva', 'up', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('together', 'Stephen Sanchez', 'science', 'nation');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('else', 'Leonard Gray', 'fact', 'yourself');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('then', 'Samuel White', 'only', 'cut');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('worry', 'Robert Peterson', 'action', 'bed');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1013, 'former', 'South Rachelborough', 'red', 'Massachusetts', 'Maryland');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1014, 'least', 'Bradleychester', 'wife', 'Texas', 'North Carolina');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1015, 'police', 'New Saraside', 'give', 'Delaware', 'Nebraska');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1016, 'much', 'West Ryan', 'price', 'Washington', 'Montana');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1017, 'according', 'Castanedachester', 'shake', 'Florida', 'Pennsylvania');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1018, 'yes', 'South Jeffrey', 'company', 'South Carolina', 'Oregon');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1019, 'he', 'Tuckerfurt', 'though', 'Ohio', 'Colorado');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1020, 'fire', 'Elizabethfurt', 'manage', 'Alaska', 'Tennessee');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1021, 'effort', 'Lake Thomas', 'material', 'Nevada', 'Minnesota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1022, 'service', 'Westtown', 'on', 'West Virginia', 'Vermont');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1023, 'investment', 'West Jeffreybury', 'nice', 'Oklahoma', 'New Jersey');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1024, 'middle', 'Elizabethstad', 'guy', 'Michigan', 'Louisiana');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('same', 'James', 'Thompson', 'justin69@example.net', 'property', 'tell', '001-534-833-2003x79176', 1013, 'data');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('find', 'Elizabeth', 'Carroll', 'steven73@example.net', 'president', 'tell', '563.320.1632x8708', 1013, 'data');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('once', 'Nicholas', 'Sullivan', 'yleon@example.net', 'government', 'tell', '927.488.9579x868', 1013, 'data');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('care', 'Kaitlin', 'Bass', 'donnacampbell@example.net', 'better', 'tell', '001-577-643-4873x4714', 1013, 'data');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('later', 'Hunter', 'Rogers', 'fking@example.com', 'those', NULL, '319.237.4529x9124', 1017, 'front');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('central', 'Jorge', 'Hobbs', 'currybrett@example.com', 'pretty', NULL, '296-763-1931x4919', 1017, 'front');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('trial', 'Mark', 'Ramirez', 'debraharrington@example.net', 'claim', NULL, '+1-365-818-5067', 1017, 'front');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('main', 'Shawn', 'Bean', 'websterstefanie@example.org', 'edge', NULL, '(672)762-8498x776', 1017, 'front');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('follow', 'Jennifer', 'Vaughn', 'tina34@example.org', 'turn', NULL, '277.452.0471x1671', 1021, 'together');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('enter', 'Leslie', 'Lee', 'harry08@example.org', 'actually', NULL, '(594)813-1869', 1021, 'together');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('during', 'Julia', 'Rodgers', 'brandon08@example.com', 'painting', NULL, '574.696.4990x913', 1021, 'together');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('camera', 'Stephanie', 'Hill', 'danamullins@example.org', 'feel', NULL, '+1-212-532-8120x67974', 1021, 'together');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t_shirt_size FROM member GROUP BY t_shirt_size ORDER BY COUNT(t_shirt_size) DESC, t_shirt_size NULLS LAST LIMIT 1;

/*
Gold Result:
('tell',)
*/

-- Prediction Query
SELECT t_shirt_size FROM member GROUP BY t_shirt_size ORDER BY COUNT(*) DESC, t_shirt_size NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/