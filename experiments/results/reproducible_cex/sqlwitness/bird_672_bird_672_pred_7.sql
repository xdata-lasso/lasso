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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 4, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'United Kingdom', 'United Kingdom', 0, NULL, NULL, 5, 5, 'default1'), (4, 5, NULL, 'United Kingdom', '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default2', 4, 5, 5, 5, 0, 'United Kingdom'), (3, 3, NULL, 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default1', 4, 3, 0, 5, 5, 'United Kingdom'), (5, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', NULL, NULL, NULL, 1, 4, 'default2'), (0, 4, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'United Kingdom', 'default2', 'default2', 5, 4, NULL, 1, 3, NULL), (2, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'United Kingdom', 'default2', NULL, 0, 1, NULL, 4, 1, NULL), (6, 0, NULL, 'United Kingdom', '2023-01-01 01:00:00.000000', 'default2', 'default1', 'default2', 5, 1, 5, NULL, 5, 'default2'), (7, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', 'United Kingdom', 'United Kingdom', NULL, 4, 4, 1, 0, NULL, NULL), (8, 3, NULL, NULL, '2023-01-01 01:00:00.000000', 'United Kingdom', 'United Kingdom', 'United Kingdom', 5, 0, 5, 1, 5, NULL), (9, 5, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default1', 0, 0, 4, 1, 3, 'default1'), (10, 3, NULL, 'United Kingdom', '2023-01-01 00:00:00.000000', 'United Kingdom', 'default1', NULL, 1, 1, 4, 0, 1, 'United Kingdom');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 7, 8, 5, 5, '2023-01-01 01:00:00.000000', 1, 0, 'United Kingdom', '2023-01-01 00:00:00.000000', 'default1', 'default1', 3, 0, 4, NULL, '2023-01-01 01:00:00.000000', 3, '2023-01-01 01:00:00.000000', NULL, NULL), (1, 3, 8, NULL, 1, '2023-01-01 01:00:00.000000', 5, 3, 'default2', NULL, 'United Kingdom', 'United Kingdom', 3, 1, 4, NULL, '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'default2', 'default2'), (3, 6, 2, 3, 0, '2023-01-01 00:00:00.000000', 0, 1, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 4, NULL, 5, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 00:00:00.000000', NULL, 'default2'), (5, 4, 6, 5, 3, '2023-01-01 00:00:00.000000', 0, 4, 'United Kingdom', NULL, 'default1', NULL, 5, 3, 1, NULL, '2023-01-01 01:00:00.000000', 3, '2023-01-01 00:00:00.000000', 'United Kingdom', 'default1'), (4, 1, 6, 0, 1, NULL, NULL, 1, NULL, NULL, 'default2', 'default1', 0, 0, 3, NULL, NULL, 4, '2023-01-01 00:00:00.000000', 'default1', 'United Kingdom'), (2, 3, 9, NULL, NULL, NULL, 0, 3, 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 3, 1, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 4, NULL, NULL, 'default1'), (6, 6, NULL, 5, 0, NULL, 1, 0, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default1', 3, 0, 1, NULL, '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (7, NULL, 3, 1, 4, '2023-01-01 01:00:00.000000', 4, 4, 'default2', NULL, 'default2', 'default1', 3, 4, 4, NULL, NULL, 1, '2023-01-01 01:00:00.000000', 'default1', 'default2'), (8, 10, 1, 1, 0, '2023-01-01 01:00:00.000000', 4, 3, 'default1', '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 4, 0, NULL, NULL, 1, NULL, 'default1', 'default1'), (9, 2, 3, 3, 5, '2023-01-01 01:00:00.000000', 5, 0, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, 3, 1, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.Location = 'United Kingdom' AND T2.FavoriteCount >= 4;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT users.id) AS usercount FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE users.location = 'United Kingdom' AND posts.favoritecount >= 4;

/*
Prediction Result:
(1,)
*/