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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 't1__352f02', 'nprmdposii', -1823627488, -1209887326, -1399556171, -2147483648, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 742285925, -747753377, '2024-01-27 22:01:59+00:00', 1119186446, 781505063, 'rofqyp5s5b', -2147483648, '2020-03-11 14:09:37+00:00', 't1__352f02', '02eu', -868774469, -1068298341, -314162272, -2147483648, '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00', -525979501, '2025-09-09 06:56:52+00:00', 'oo3o9hl72kle', 'x14ji7zwau2d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -953437896, -1097120355, '2022-10-12 16:19:32+00:00', 176380444, -977635379, 'sl0', -2147483648, '2020-03-25 00:00:06+00:00', 't1__352f02', 'yp5qi2rk', -705985602, 537874887, -461695645, -2147483648, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -1642259219, 1298861365, '1969-12-31 23:59:59+00:00', 1968874827, -664193365, 'cx5hn', -2147483648, '2020-05-10 07:36:02+00:00', 't1__352f02', 'rjtu', -361507387, 401805964, -1485777725, -2147483648, '2022-03-23 04:34:16+00:00', '2024-08-10 07:57:32+00:00', -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 32204797, -1672720816, '1970-01-01 00:00:00+00:00', -1520489792, -658391922, 'q7x', -2147483648, '2020-03-06 15:32:29+00:00', 't1__5fea5f', '72fxa7ryfd', 564390026, -1259474148, 2011234363, -2147483648, '2021-04-25 14:26:05+00:00', '2020-01-23 21:20:16+00:00', -7597509, '2025-07-17 09:46:47+00:00', '5o', 'rg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (1, '2024-05-26 02:52:16+00:00', 1, 1, -1585009206);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2020-03-11 08:08:02+00:00', 2, 2, -1929953647);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-1, '2020-06-19 19:37:13+00:00', 0, 2, 1074760385);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (0, '2022-08-16 10:09:33+00:00', 0, -1, 600440952);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, '2024-11-10 21:13:22+00:00', 1, -1, -1538707438);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (3, '2020-06-27 17:29:33+00:00', 1, -1, -1826414375);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (4, '2022-06-06 02:35:43+00:00', 4, -1, -664303813);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN postLinks AS T2 ON T2.PostId = T1.Id ORDER BY T1.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__5fea5f',)
*/

-- Prediction Query
SELECT DISTINCT p.Title FROM posts AS p INNER JOIN postLinks AS pl ON p.Id = pl.PostId WHERE pl.CreationDate = (SELECT MIN(CreationDate) FROM postLinks);

/*
Prediction Result:
('t1__352f02',)
*/