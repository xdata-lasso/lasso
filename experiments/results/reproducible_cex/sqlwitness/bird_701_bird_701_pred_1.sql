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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, NULL, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default2', 1, -1, 101, 51, 99, 'default2'), (0, 100, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 'default2', 'default1', 99, 50, 1, 49, 100, NULL), (49, 100, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default1', NULL, 1, 50, 51, NULL, NULL), (100, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', -1, -1, NULL, -1, 100, 'default2'), (50, 51, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', NULL, 'default1', NULL, 49, 50, 51, NULL, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (99, 100, 49, 0, -1, '2023-01-01 00:00:00.000000', 100, 101, 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 51, -1, 50, '2023-01-01 01:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (100, 2, 49, 99, 99, '2023-01-01 01:00:00.000000', 51, 101, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default2', -1, 50, 2, '2023-01-01 01:00:00.000000', NULL, 51, '2023-01-01 01:00:00.000000', NULL, 'default2'), (101, 100, 0, NULL, 99, '2023-01-01 01:00:00.000000', 1, 50, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default2', 0, -1, 99, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 50, NULL, 'default1', 'default2'), (0, 49, 0, 99, 49, '2023-01-01 01:00:00.000000', 50, 49, 'default1', NULL, NULL, 'default2', 1, 49, 101, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', -1, NULL, NULL, 'default1'), (51, 100, 100, 1, 51, '2023-01-01 00:00:00.000000', 0, 49, 'default2', NULL, 'default1', 'default1', 100, 101, 1, '2023-01-01 00:00:00.000000', NULL, 50, '2023-01-01 00:00:00.000000', NULL, NULL), (49, NULL, 50, 50, 50, NULL, 51, NULL, 'default2', NULL, NULL, 'default2', 101, 0, 50, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 51, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (-1, NULL, 2, 51, 50, '2023-01-01 00:00:00.000000', 2, 51, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 101, 99, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 100, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (1, 100, 49, -1, 101, '2023-01-01 01:00:00.000000', NULL, -1, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default1', NULL, 49, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.Score >= 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN (SELECT MAX(Reputation) AS max_reputation FROM users) AS T3 ON T1.Reputation = T3.max_reputation;

/*
Gold Result:
(60.0,)
*/

-- Prediction Query
SELECT CAST(COUNT("posts"."id") FILTER(WHERE "posts"."score" > 50) AS REAL) * 100 / COUNT("posts"."id") FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" WHERE "users"."reputation" = (SELECT MAX("reputation") FROM "users");

/*
Prediction Result:
(40.0,)
*/