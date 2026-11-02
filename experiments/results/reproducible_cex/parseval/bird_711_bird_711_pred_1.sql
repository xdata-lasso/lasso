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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, -1910425938, 'tilbn', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 40, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 418417917, '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, 1775126557, 40, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1485335077, '2024-12-22 09:14:04+00:00', 'rq13pyu', '2024-06-05 19:22:34+00:00', 'd99rljsl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 462974032, '2021-12-31 07:20:26+00:00', 'siie', '2024-02-29 12:08:41+00:00', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, -1179823637, 1119186446, 1, 'rqrofqyp5s');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -2081315180, '2023-10-12 22:40:24+00:00', 'dwyrq13pyu78', '2020-06-02 21:50:32+00:00', '9rljsl0b4', 'p5qi2rk', '9v', 556727997, 1178000634, 1836127587, -1529584866, 40, 'd2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -688509700, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, 1, 'dz79fjg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, -2147483648, 0, '76nium52', '2025-09-21 09:36:38+00:00', 1, 'buo4nrq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, 0, '9uxj4hwbdvl', '2022-01-26 11:13:48+00:00', 1, 'h2gndqwnqcx5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, -2147483648, 0, 'cprj', '2022-08-03 01:56:16+00:00', 1, '0dz79f');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, 1, 'dqv0gcb98ozk', '2023-12-12 02:47:46+00:00', 1, 'bilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, 0, 'k', '2024-04-29 16:45:22+00:00', 1, 'h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, 0, '8j', '2022-05-28 16:44:30+00:00', 1, 'wlq7xb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, -2147483648, 0, 'p', '2024-04-12 00:38:47+00:00', 2, 'uhv');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483648, 0, 'tti', '2021-07-20 10:41:36+00:00', 5, 'n');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, 1, 'bbp02eutliqa', '2023-08-20 20:02:04+00:00', 6, 'ryytoo3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, -2147483648, 1, 'hl72klex1', '2024-02-08 07:13:40+00:00', 7, 'i7z');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, NULL, 'value', '2024-06-15 00:00:00+00:00', 8, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, -2147483648, NULL, 'value', '2024-06-15 00:00:00+00:00', 9, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, -2147483648, NULL, 'value', '2024-06-15 00:00:00+00:00', 10, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Score = 0 AND T2.Age = 40;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.UserId) FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Score = 0 AND T2.Age = 40;

/*
Prediction Result:
(1,)
*/