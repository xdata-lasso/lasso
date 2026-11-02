-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1099, 1103, '1977-04-14', 'Erin Johnson', '1981-08-18', 'https://www.estes.biz/', '484 Nguyen Square
Angelaborough, MT 87654', 'popular', 1107, 1111, 1115, 1119, 1123, 'https://johnston.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1100, 1108.0, '1977-04-15', 'Erin Johnson', '1981-08-19', 'https://obrien-dixon.biz/', 'USNS Gilbert
FPO AA 53726', 'to', 1126.0, 1132.0, 1138.0, 1144.0, 1150.0, 'http://www.watts.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1101, 1113.0, '1977-04-16', 'Erin Johnson', '1981-08-20', 'http://fletcher.net/', '4369 Marshall Mills
New Thomas, MH 96964', 'special', 1145.0, 1153.0, 1161.0, 1169.0, 1177.0, 'https://www.brock.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1102, 1118.0, '1977-04-17', 'Erin Johnson', '1981-08-21', 'http://jones-beck.com/', '8951 Emily Fork
East Andrew, IA 62778', 'baby', 1164.0, 1174.0, 1184.0, 1194.0, 1204.0, 'https://www.wright.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1131, 1135, '1989-05-03', 'David Wright', '1993-09-07', 'https://allen.com/', 'PSC 9096, Box 7054
APO AA 55422', 'door', 1139, 1143, 1147, 1151, 1155, 'http://www.gonzalez.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1132, 1140.0, '1989-05-04', 'David Wright', '1993-09-08', 'https://orozco-miller.com/', '3467 Paul Skyway
Ramseymouth, PW 17229', 'rate', 1158.0, 1164.0, 1170.0, 1176.0, 1182.0, 'http://www.wells.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1133, 1145.0, '1989-05-05', 'David Wright', '1993-09-09', 'http://hernandez.com/', 'Unit 8069 Box 9016
DPO AE 61016', 'authority', 1177.0, 1185.0, 1193.0, 1201.0, 1209.0, 'http://scott.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1134, 1150.0, '1989-05-06', 'David Wright', '1993-09-10', 'https://clark.biz/', '5375 Juarez Light Suite 641
Smithside, AR 46371', 'statement', 1196.0, 1206.0, 1216.0, 1226.0, 1236.0, 'http://lane.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1163, 1167, '1972-06-15', 'David Wright', '1976-10-19', 'http://patterson.com/', '7379 Rogers Park
Hunterborough, MI 34363', 'picture', 1171, 1175, 1179, 1183, 1187, 'http://ward.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1164, 1172.0, '1972-06-16', 'David Wright', '1976-10-20', 'http://garcia-yu.info/', '083 John Lodge Suite 837
Westtown, CO 39067', 'fear', 1190.0, 1196.0, 1202.0, 1208.0, 1214.0, 'http://mccann.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1165, 1177.0, '1972-06-17', 'David Wright', '1976-10-21', 'http://gross.com/', '9578 Coleman Summit
Michaelmouth, KY 40690', 'black', 1209.0, 1217.0, 1225.0, 1233.0, 1241.0, 'http://salas.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1166, 1182.0, '1972-06-18', 'David Wright', '1976-10-22', 'https://petersen-vargas.com/', '351 James Streets
Hillshire, WV 69266', 'there', 1228.0, 1238.0, 1248.0, 1258.0, 1268.0, 'https://peterson-sheppard.com/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1127, 1099, 'Victoria Larson', '1985-01-22');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1128, 1099, 'Stephanie Salazar', '1985-01-23');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1129, 1099, 'Kathy Rivas', '1985-01-24');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1130, 1099, 'Stephanie Manning', '1985-01-25');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1159, 1131, NULL, '1997-02-11');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1160, 1131, NULL, '1997-02-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1161, 1131, NULL, '1997-02-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1162, 1131, NULL, '1997-02-14');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1191, 1163, 'Karen Short', '1980-03-23');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1192, 1163, 'Benjamin Soto', '1980-03-24');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1193, 1163, 'Chase Hart', '1980-03-25');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1194, 1163, 'Xavier Wilson', '1980-03-26');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1195, 1099, NULL, '1985-01-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('David Wright',)
*/

-- Prediction Query
SELECT "users"."displayname" FROM "users" INNER JOIN "badges" ON "users"."id" = "badges"."userid" GROUP BY "badges"."userid" ORDER BY COUNT("badges"."id") DESC, "users"."displayname" NULLS LAST LIMIT 1;

/*
Prediction Result:
('Erin Johnson',)
*/