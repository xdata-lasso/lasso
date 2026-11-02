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
-- Tests AVG(DISTINCT ...) vs AVG(...), NULL handling in UpVotes and Age, and NULL OwnerUserId in posts.
INSERT INTO users (Id, UpVotes, Age) VALUES (1, 50, 25);
INSERT INTO users (Id, UpVotes, Age) VALUES (2, 50, 25);
INSERT INTO users (Id, UpVotes, Age) VALUES (3, 110, NULL);
INSERT INTO users (Id, UpVotes, Age) VALUES (4, NULL, 55);
-- User 1: 11 posts
INSERT INTO posts (Id, OwnerUserId) VALUES (1, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (2, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (3, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (4, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (5, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (6, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (7, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (8, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (9, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (10, 1);
INSERT INTO posts (Id, OwnerUserId) VALUES (11, 1);
-- User 2: 11 posts (Identical UpVotes and Age to User 1 to catch AVG(DISTINCT))
INSERT INTO posts (Id, OwnerUserId) VALUES (12, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (13, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (14, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (15, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (16, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (17, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (18, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (19, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (20, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (21, 2);
INSERT INTO posts (Id, OwnerUserId) VALUES (22, 2);
-- User 3: 11 posts (Age is NULL)
INSERT INTO posts (Id, OwnerUserId) VALUES (23, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (24, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (25, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (26, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (27, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (28, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (29, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (30, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (31, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (32, 3);
INSERT INTO posts (Id, OwnerUserId) VALUES (33, 3);
-- User 4: 11 posts (UpVotes is NULL)
INSERT INTO posts (Id, OwnerUserId) VALUES (34, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (35, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (36, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (37, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (38, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (39, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (40, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (41, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (42, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (43, 4);
INSERT INTO posts (Id, OwnerUserId) VALUES (44, 4);
-- 11 posts with NULL OwnerUserId (should not join to any user)
INSERT INTO posts (Id, OwnerUserId) VALUES (45, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (46, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (47, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (48, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (49, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (50, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (51, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (52, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (53, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (54, NULL);
INSERT INTO posts (Id, OwnerUserId) VALUES (55, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.UpVotes), AVG(T1.Age) FROM users AS T1 INNER JOIN (SELECT OwnerUserId, COUNT(*) AS post_count FROM posts GROUP BY OwnerUserId HAVING post_count > 10) AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(70.0, 35.0)
*/

-- Prediction Query
SELECT CAST(SUM(UpVotes) AS REAL) / COUNT(Id) AS AverageUpVotes, CAST(SUM(Age) AS REAL) / COUNT(Id) AS AverageUserAge FROM users WHERE Id IN (SELECT OwnerUserId FROM posts GROUP BY OwnerUserId HAVING COUNT(OwnerUserId) > 10);

/*
Prediction Result:
(52.5, 26.25)
*/