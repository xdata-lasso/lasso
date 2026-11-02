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
-- DATASET 1
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (1, 1000, 500, 20, 5, 30, 101);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (2, 2000, 600, 20, 10, 40, 102);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (3, 3000, 700, 50, 15, 25, 103);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (4, 4000, 800, 100, 20, 60, 104);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (1, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (2, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (3, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (4, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (5, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (6, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (7, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (8, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (9, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (10, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (11, 1, 4, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (12, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (13, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (14, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (15, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (16, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (17, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (18, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (19, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (20, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (21, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (22, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (23, 2, 1, 20);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (24, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (25, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (26, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (27, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (28, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (29, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (30, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (31, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (32, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (33, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (34, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (35, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (36, 3, 2, 30);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (37, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (38, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (39, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (40, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (41, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (42, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (43, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (44, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (45, 4, 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (46, 4, 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.UpVotes), AVG(T1.Age) FROM users AS T1 INNER JOIN (SELECT OwnerUserId, COUNT(*) AS post_count FROM posts GROUP BY OwnerUserId HAVING post_count > 10) AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(30.0, 31.666666666666668)
*/

-- Prediction Query
SELECT AVG(u.UpVotes) AS AverageUpVotes, AVG(u.Age) AS AverageAge FROM users AS u JOIN posts AS p ON u.Id = p.OwnerUserId GROUP BY u.Id HAVING COUNT(p.Id) > 10;

/*
Prediction Result:
(20.0, 30.0)
(20.0, 40.0)
(50.0, 25.0)
*/