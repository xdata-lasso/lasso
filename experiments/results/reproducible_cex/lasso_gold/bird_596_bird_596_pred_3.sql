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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3108, 3112, '1972-11-05', 'Renee Gonzales', '1976-04-09', 'http://www.bailey.org/', '782 Morris Row
Danielhaven, TN 09240', 'data', 3116, 3120, 3124, 3128, 3132, 'http://garcia.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3109, 3117.0, '1972-11-06', 'Michael Howard', '1976-04-10', 'http://www.moore.com/', '03173 Anthony Row
Barretthaven, RI 92423', 'never', 3135.0, 3141.0, 3147.0, 3153.0, 3159.0, 'https://www.sparks.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3110, 3122.0, '1972-11-07', 'Steven Washington', '1976-04-11', 'https://www.hunter.org/', '3910 Diana Village
South Laurieton, MN 73641', 'realize', 3154.0, 3162.0, 3170.0, 3178.0, 3186.0, 'https://www.murillo.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3111, 3127.0, '1972-11-08', 'Edward Terry', '1976-04-12', 'https://www.le-barrett.net/', '0948 Jessica Village Suite 138
North Jessicaside, MS 25333', 'over', 3173.0, 3183.0, 3193.0, 3203.0, 3213.0, 'https://duran-jordan.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3186, 3194.0, '1976-11-16', 'Jennifer Parrish', '1980-04-20', 'http://wolfe.biz/', '66553 Cooper Shoal
Port Kevinstad, RI 58462', 'as', 3212.0, 3218.0, 3224.0, 3230.0, 3236.0, 'https://smith.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3187, 3199.0, '1976-11-17', 'Cristina Delgado', '1980-04-21', 'https://www.reynolds.com/', '33521 Jodi Gardens Apt. 405
West Shannontown, MA 27896', 'federal', 3231.0, 3239.0, 3247.0, 3255.0, 3263.0, 'http://bray.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3188, 3204.0, '1976-11-18', 'Alexandra Waters', '1980-04-22', 'http://alvarez.com/', '88487 Heather Skyway
South Brandyhaven, AZ 33984', 'deep', 3250.0, 3260.0, 3270.0, 3280.0, 3290.0, 'http://www.mason.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3157, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3234, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3136, 3108, 'Krystal Moore', '1980-08-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3213, 3108, 'Kristine Lewis', '1984-08-23');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3137, 3141, 3145, '1981-09-14', 3149, 3153, 'space', 3157, '1985-02-18', 'Forest/woodland manager', 'industry', 3161, 3165, 3169, 3108, '1989-06-22', '1993-10-03', 3173, '1997-03-07', 'Ms. Kelly Holder', 'Tammy Moore');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3138, 3146.0, 3152.0, '1981-09-15', 3160.0, 3166.0, 'oil', 3157, '1985-02-19', 'Media buyer', 'a', 3186.0, 3192.0, 3198.0, 3108, '1989-06-23', '1993-10-04', 3210.0, '1997-03-08', 'Eric Walker', 'Henry Taylor');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3139, 3151.0, 3159.0, '1981-09-16', 3171.0, 3179.0, 'with', 3157, '1985-02-20', 'Production manager', 'she', 3211.0, 3219.0, 3227.0, 3108, '1989-06-24', '1993-10-05', 3247.0, '1997-03-09', 'Alison Short', 'Kevin Hall');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3140, 3156.0, 3166.0, '1981-09-17', 3182.0, 3192.0, 'size', 3157, '1985-02-21', 'Product/process development scientist', 'already', 3236.0, 3246.0, 3256.0, 3108, '1989-06-25', '1993-10-06', 3284.0, '1997-03-10', 'Desiree Spencer', 'Anna Ross');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3214, 3218, 3222, '1985-09-01', 3226, 3230, 'next', 3234, '1989-02-05', 'Nurse, learning disability', 'return', 3238, 3242, 3246, 3108, '1993-06-09', '1997-10-13', 3250, '1972-03-17', 'Zachary Irwin', 'James Taylor');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3215, 3223.0, 3229.0, '1985-09-02', 3237.0, 3243.0, 'focus', 3234, '1989-02-06', 'Designer, graphic', 'he', 3263.0, 3269.0, 3275.0, 3108, '1993-06-10', '1997-10-14', 3287.0, '1972-03-18', 'Antonio Scott', 'Kelly Gregory');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3216, 3228.0, 3236.0, '1985-09-03', 3248.0, 3256.0, 'goal', 3234, '1989-02-07', 'Adult nurse', 'hear', 3288.0, 3296.0, 3304.0, 3108, '1993-06-11', '1997-10-15', 3324.0, '1972-03-19', 'Zachary Mooney', 'Melissa Butler');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3217, 3233.0, 3243.0, '1985-09-04', 3259.0, 3269.0, 'might', 3234, '1989-02-08', 'Loss adjuster, chartered', 'process', 3313.0, 3323.0, 3333.0, 3108, '1993-06-12', '1997-10-16', 3361.0, '1972-03-20', 'Tiffany Perez', 'Jessica Edwards');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3177, 3137, 3181, 'whose', '1972-07-11', 3108, 'Rebecca Thompson');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3178, 3137, 3188.0, 'director', '1972-07-12', 3108, 'Melissa Johnston');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3179, 3137, 3195.0, 'similar', '1972-07-13', 3108, 'Linda Evans');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3180, 3137, 3202.0, 'bank', '1972-07-14', 3108, 'Laura Miller');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3254, 3214, 3258, 'point', '1976-07-21', 3108, 'Matthew Carpenter');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3255, 3214, 3265.0, 'girl', '1976-07-22', 3108, 'Christina Taylor');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3256, 3214, 3272.0, 'list', '1976-07-23', 3108, 'Stephanie Browning');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3257, 3214, 3279.0, 'occur', '1976-07-24', 3108, 'Terry Carrillo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('Krystal Moore',)
*/

-- Prediction Query
SELECT T2.Name FROM comments AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId INNER JOIN users AS T3 ON T1.UserId = T3.Id GROUP BY T1.UserId ORDER BY COUNT(T1.Id) DESC, T2.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Kristine Lewis',)
*/