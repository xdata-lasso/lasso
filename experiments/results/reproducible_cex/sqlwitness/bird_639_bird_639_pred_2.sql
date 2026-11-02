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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, -1, NULL, 'Community', '2023-01-01 01:00:00.000000', 'Community', '%', '%', 2, -1, 0, NULL, NULL, 'default2'), (1, 1, '2023-01-01 01:00:00.000000', 'r', NULL, NULL, 'default2', 'default2', 2, 100, -1, -1, 101, 'default1'), (101, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'r', 'Community', -1, -1, 2, 0, 99, NULL), (100, 100, NULL, 'Community', '2023-01-01 00:00:00.000000', '%', NULL, '%', -1, -1, 100, 101, 99, NULL), (0, 1, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, '%', NULL, 0, -1, 0, NULL, NULL, 'r'), (99, -1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'r', 'default2', NULL, 0, 2, 99, NULL, 99, 'r'), (-1, 100, NULL, 'default1', NULL, 'default1', 'default1', 'Community', 2, 100, 1, 1, 101, 'default1'), (3, -1, '2023-01-01 01:00:00.000000', 'r', '2023-01-01 00:00:00.000000', 'default2', '%', 'default2', 2, 100, 1, NULL, 2, 'default2'), (4, -1, '2023-01-01 00:00:00.000000', 'Community', '2023-01-01 01:00:00.000000', 'r', 'Community', NULL, 2, 100, 100, 0, 2, 'r'), (5, 2, NULL, 'default1', '2023-01-01 01:00:00.000000', '%', NULL, NULL, -1, 2, 0, 100, -1, 'default1'), (6, 101, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'r', 'default2', 'default2', 99, 2, 101, 101, 101, NULL), (7, 2, NULL, 'r', '2023-01-01 00:00:00.000000', 'Community', 'default2', 'default1', -1, NULL, 99, NULL, 0, 'Community');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (2, 2, 4, 2, 101, '2023-01-01 01:00:00.000000', 1, 100, '%', '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL, -1, NULL, '2023-01-01 01:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default2', '%'), (100, 2, -1, -1, 101, '2023-01-01 00:00:00.000000', 2, 101, 'default2', NULL, 'default2', 'r', 2, -1, 100, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 101, '2023-01-01 00:00:00.000000', '%', 'Community');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (-1, 100, '%', 0, 100), (2, 100, 'Community', -1, 99), (0, NULL, 'Community', -1, 101), (100, NULL, 'default2', 1, NULL), (1, 2, 'default1', 0, 99), (101, 100, 'Community', 101, 101), (99, 100, 'Community', -1, 0), (3, 2, 'Community', 0, 100), (4, NULL, 'default1', 0, 0), (5, 2, NULL, 101, 101);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 100, 100, -1, NULL, '2023-01-01 01:00:00.000000', 'Community', '%', 'default1'), (100, 2, 0, 101, 'r', '2023-01-01 01:00:00.000000', 'Community', '%', 'Community'), (2, 100, 2, 0, 'Community', '2023-01-01 00:00:00.000000', NULL, 'r', 'Community'), (-1, NULL, -1, NULL, '%', '2023-01-01 01:00:00.000000', '%', '%', 'default2'), (99, 2, 100, 99, 'r', '2023-01-01 00:00:00.000000', NULL, NULL, 'default1'), (1, 2, 6, 99, 'r', NULL, 'default2', 'r', 'Community'), (101, 100, -1, 1, 'Community', '2023-01-01 00:00:00.000000', 'Community', 'default2', 'r'), (3, NULL, NULL, -1, 'default1', NULL, 'default2', 'default1', 'default2'), (4, NULL, 3, 99, '%', NULL, '%', 'default2', 'default1'), (5, 100, 100, 101, 'default2', NULL, 'Community', NULL, '%'), (6, NULL, 2, 1, 'default2', NULL, '%', 'r', 'default2'), (7, 2, 101, 0, 'Community', '2023-01-01 01:00:00.000000', '%', 'r', 'Community');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "tags"."tagname" = 'r' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("posts"."id") AS percentage FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" INNER JOIN "tags" ON "posts"."tags" LIKE '%' || "tags"."tagname" || '%' WHERE "users"."displayname" = 'Community';

/*
Prediction Result:
(None,)
*/