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
-- DATASET 2
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (1, 100, 50, NULL, 1, 20, 201);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (2, 200, 60, 40, 2, NULL, 202);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (3, 300, 70, 60, 3, 40, 203);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (4, 400, 80, 999, 4, 99, 204);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (1, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (2, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (3, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (4, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (5, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (6, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (7, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (8, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (9, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (10, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (11, 1, 4, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (12, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (13, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (14, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (15, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (16, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (17, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (18, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (19, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (20, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (21, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (22, 2, 4, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (23, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (24, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (25, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (26, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (27, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (28, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (29, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (30, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (31, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (32, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (33, 3, 1, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (34, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (35, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (36, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (37, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (38, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (39, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (40, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (41, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (42, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (43, NULL, 4, 0);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (44, NULL, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.UpVotes), AVG(T1.Age) FROM users AS T1 INNER JOIN (SELECT OwnerUserId, COUNT(*) AS post_count FROM posts GROUP BY OwnerUserId HAVING post_count > 10) AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(50.0, 30.0)
*/

-- Prediction Query
SELECT CAST(SUM(UpVotes) AS REAL) / COUNT(Id) AS AverageUpVotes, CAST(SUM(Age) AS REAL) / COUNT(Id) AS AverageUserAge FROM users WHERE Id IN (SELECT OwnerUserId FROM posts GROUP BY OwnerUserId HAVING COUNT(OwnerUserId) > 10);

/*
Prediction Result:
(33.333333333333336, 20.0)
*/