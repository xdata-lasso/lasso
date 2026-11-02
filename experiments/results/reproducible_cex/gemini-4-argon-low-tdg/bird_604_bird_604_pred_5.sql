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
-- Tests exact boundary conditions for post_count (> 10 vs >= 10), weighted vs unweighted averages across users with different post counts (11 vs 12), and inclusion/exclusion of users with 0 or <= 10 posts.
INSERT INTO users (Id, UpVotes, DownVotes, Reputation, Views, Age) VALUES (1, 100, 10, 500, 1000, 20);
INSERT INTO users (Id, UpVotes, DownVotes, Reputation, Views, Age) VALUES (2, 200, 20, 600, 2000, 30);
INSERT INTO users (Id, UpVotes, DownVotes, Reputation, Views, Age) VALUES (3, 500, 50, 700, 3000, 40);
INSERT INTO users (Id, UpVotes, DownVotes, Reputation, Views, Age) VALUES (4, 1000, 100, 800, 4000, 50);
-- User 1 has exactly 10 posts (should be excluded by > 10)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (101, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (102, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (103, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (104, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (105, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (106, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (107, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (108, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (109, 1, 2, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (110, 1, 2, 5);
-- User 2 has 11 posts (should be included)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (201, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (202, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (203, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (204, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (205, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (206, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (207, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (208, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (209, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (210, 2, 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (211, 2, 1, 10);
-- User 3 has 12 posts (should be included; tests unweighted AVG vs flat-join weighted AVG)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (301, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (302, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (303, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (304, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (305, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (306, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (307, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (308, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (309, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (310, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (311, 3, 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Score) VALUES (312, 3, 1, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.UpVotes), AVG(T1.Age) FROM users AS T1 INNER JOIN (SELECT OwnerUserId, COUNT(*) AS post_count FROM posts GROUP BY OwnerUserId HAVING post_count > 10) AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(350.0, 35.0)
*/

-- Prediction Query
SELECT CAST(SUM(T1.UpVotes) AS REAL) / COUNT(T1.Id), CAST(SUM(T1.Age) AS REAL) / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId GROUP BY T2.OwnerUserId HAVING COUNT(T2.OwnerUserId) > 10;

/*
Prediction Result:
(200.0, 30.0)
(500.0, 40.0)
*/