-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1602, 'Joshua Mata', 1902, 1903, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1603, 'Susan Rivas', 1902, 1912.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1604, 'Roger Olson', 1902, 1921.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1605, 'Nicole Morgan', 1902, 1930.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1606, 'Victor Taylor', 1902, 1939.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1607, 'Shannon Ramsey', 1902, 1948.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1608, 'Tracy Ballard', 1902, 1957.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1609, 'Richard Smith', 1902, 1966.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1610, 'Jordan Chambers', 1902, 1975.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1611, 'Lauren Carson', 1902, 1984.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1612, 'Ashley Hall', 1902, 1993.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1613, 'Stephen Hoffman', 1902, 2002.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1614, 'Connie Brown', 1902, 2011.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1615, 'Susan Turner', 1902, 2020.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1616, 'Charles Shah', 1902, 2029.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1617, 'Johnathan Davis', 1902, 2038.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1618, 'Brandy Chavez', 1902, 2047.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1619, 'Natalie Bautista', 1902, 2056.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1620, 'Patrick Moore', 1902, 2065.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1621, 'Brett Burns', 1902, 2074.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1622, 'Trevor Johnson', 1902, 2083.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1623, 'Jeremy Sampson', 1902, 2092.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1624, 'Ariana Jennings', 1902, 2101.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1625, 'Vanessa Howard', 1902, 2110.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1626, 'Colton Martinez', 1902, 2119.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1627, 'Jordan Bates', 1902, 2128.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1628, 'Linda Smith', 1902, 2137.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1629, 'Dana Martinez', 1902, 2146.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1630, 'Andrea Hubbard', 1902, 2155.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1631, 'Daniel Kane', 1902, 2164.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1632, 'Charles Lester', 1902, 2173.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1633, 'Scott Thomas', 1902, 2182.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1634, 'David Thompson', 1902, 2191.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1635, 'Allison Smith', 1902, 2200.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1636, 'Cynthia Morris', 1902, 2209.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1637, 'Anthony Harmon', 1902, 2218.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1638, 'Nichole Alvarez', 1902, 2227.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1639, 'Kayla Rodriguez', 1902, 2236.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1640, 'Theresa Williams', 1902, 2245.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1641, 'Sharon Boyd', 1902, 2254.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1642, 'Victor Brown', 1902, 2263.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1643, 'James Parks', 1902, 2272.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1644, 'Theodore Jones Jr.', 1902, 2281.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1645, 'Ana Hill', 1902, 2290.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1646, 'Kimberly Nguyen', 1902, 2299.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1647, 'Kerry Chavez DDS', 1902, 2308.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1648, 'Michael Farrell', 1902, 2317.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1649, 'Patricia Le', 1902, 2326.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1650, 'Jesse Perez', 1902, 2335.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1651, 'Jesse Perry', 1902, 2344.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1652, 'Jeffery Ortega', 1902, 2353.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1653, 'Christian Leblanc', 1902, 2362.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1654, 'Ronald Davis', 1902, 2371.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1655, 'Parker Cain', 1902, 2380.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1656, 'Laurie Hoffman', 1902, 2389.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1657, 'Bryan Gomez', 1902, 2398.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1658, 'Nicole Parrish', 1902, 2407.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1659, 'Tracy Burke', 1902, 2416.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1660, 'Kenneth Lewis', 1902, 2425.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1661, 'Courtney Rodriguez', 1902, 2434.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1662, 'Holly Farmer', 1902, 2443.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1663, 'Renee Bruce', 1902, 2452.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1664, 'Sabrina Austin', 1902, 2461.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1665, 'Allison Hickman', 1902, 2470.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1666, 'Debra White', 1902, 2479.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1667, 'Ellen Morgan', 1902, 2488.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1668, 'Sergio Knight', 1902, 2497.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1669, 'Charles Schultz', 1902, 2506.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1670, 'Paul Lewis', 1902, 2515.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1671, 'Glen Wood', 1902, 2524.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1672, 'Paula Bradley', 1902, 2533.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1673, 'Anthony Moore', 1902, 2542.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1674, 'Megan Nelson', 1902, 2551.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1675, 'Karla Ramos', 1902, 2560.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1676, 'Paul Wilson', 1902, 2569.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1677, 'Douglas Gregory', 1902, 2578.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1678, 'Mr. Andrew Foster', 1902, 2587.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1679, 'Aimee Turner', 1902, 2596.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1680, 'Chad Scott', 1902, 2605.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1681, 'Adam Burgess', 1902, 2614.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1682, 'James Padilla', 1902, 2623.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1683, 'Sandra Drake', 1902, 2632.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1684, 'Scott Williams', 1902, 2641.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1685, 'Thomas Atkins', 1902, 2650.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1686, 'Laura Mckinney', 1902, 2659.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1687, 'Brian Smith', 1902, 2668.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1688, 'Robert Montgomery', 1902, 2677.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1689, 'Tamara Davis', 1902, 2686.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1690, 'Dana Chapman', 1902, 2695.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1691, 'Jennifer Collins', 1902, 2704.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1692, 'Gary Jackson', 1902, 2713.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1693, 'Ashley Hicks', 1902, 2722.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1694, 'Hannah Luna', 1902, 2731.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1695, 'Robin Young', 1902, 2740.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1696, 'Craig Morrison', 1902, 2749.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1697, 'Mary Thompson', 1902, 2758.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1698, 'Kathleen Webster', 1902, 2767.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1699, 'Joann Glass', 1902, 2776.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1700, 'Madison Weber', 1902, 2785.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1701, 'Lori Hernandez', 1902, 2794.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1702, 'Jeremy Turner', 1902, 2803.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1703, 'Anthony Romero', 1902, 2812.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1704, 'Jesse Brown', 1902, 2821.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1705, 'Angela Lin', 1902, 2830.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1706, 'Lisa Hunter', 1902, 2839.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1707, 'Julian Conner', 1902, 2848.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1708, 'Joanna Pacheco', 1902, 2857.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1709, 'Erica Alvarez', 1902, 2866.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1710, 'Antonio Garcia', 1902, 2875.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1711, 'Gwendolyn Klein', 1902, 2884.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1712, 'Carrie Wright', 1902, 2893.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1713, 'Jeffrey Mills', 1902, 2902.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1714, 'Jake Campbell', 1902, 2911.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1715, 'George Harper', 1902, 2920.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1716, 'Maria Jones', 1902, 2929.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1717, 'Michael Mitchell', 1902, 2938.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1718, 'Mary Escobar', 1902, 2947.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1719, 'Felicia Aguilar', 1902, 2956.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1720, 'Gregory Ponce', 1902, 2965.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1721, 'Jenna Larson', 1902, 2974.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1722, 'Emily Bennett', 1902, 2983.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1723, 'Robin Santiago', 1902, 2992.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1724, 'Nancy Jennings', 1902, 3001.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1725, 'Maria Henderson', 1902, 3010.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1726, 'Jack White', 1902, 3019.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1727, 'Travis Tucker', 1902, 3028.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1728, 'Chad Jones', 1902, 3037.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1729, 'Ashley Wise', 1902, 3046.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1730, 'Sophia Johnson', 1902, 3055.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1731, 'Ralph Anderson', 1902, 3064.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1732, 'Christopher Guerra', 1902, 3073.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1733, 'Rhonda Martin', 1902, 3082.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1734, 'Jason Rhodes', 1902, 3091.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1735, 'Jeremy Mitchell', 1902, 3100.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1736, 'Joann Ferguson', 1902, 3109.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1737, 'Robert Harrison', 1902, 3118.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1738, 'Holly Valentine', 1902, 3127.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1739, 'Mrs. Diane Reyes', 1902, 3136.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1740, 'Tracy Montoya', 1902, 3145.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1741, 'Brenda Wright', 1902, 3154.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1742, 'Shelly Spencer', 1902, 3163.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1743, 'Ryan Rosales', 1902, 3172.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1744, 'Phillip Nelson', 1902, 3181.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1745, 'Brittany Kim', 1902, 3190.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1746, 'Courtney Hayes', 1902, 3199.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1747, 'Alexander Brown', 1902, 3208.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1748, 'Cynthia Vang', 1902, 3217.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1749, 'Alfred Galvan', 1902, 3226.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1750, 'Marie Moody', 1902, 3235.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1751, 'Dustin Gallegos', 1902, 3244.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1752, 'Brenda Thornton', 1902, 3253.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1753, 'Aaron Miller', 1902, 3262.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1754, 'Ruben Dunn', 1902, 3271.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1755, 'Kelsey Rodriguez', 1902, 3280.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1756, 'Eric Williams', 1902, 3289.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1757, 'Riley Bryant', 1902, 3298.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1758, 'Taylor Carlson', 1902, 3307.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1759, 'Jose Allen', 1902, 3316.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1760, 'Jeffrey Mendez', 1902, 3325.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1761, 'Jason Beck', 1902, 3334.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1762, 'William Jones', 1902, 3343.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1763, 'Katie Mcneil', 1902, 3352.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1764, 'Jeanette Harrison', 1902, 3361.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1765, 'Veronica King', 1902, 3370.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1766, 'Richard Cooper', 1902, 3379.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1767, 'Lori Ingram', 1902, 3388.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1768, 'Evelyn Williams', 1902, 3397.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1769, 'Robin Thompson', 1902, 3406.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1770, 'Julie Dominguez', 1902, 3415.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1771, 'Robin Brown', 1902, 3424.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1772, 'Judith Carter', 1902, 3433.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1773, 'Curtis Williams', 1902, 3442.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1774, 'Kaylee Hays', 1902, 3451.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1775, 'Dawn Mullins', 1902, 3460.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1776, 'Howard Norman', 1902, 3469.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1777, 'Evelyn Martinez', 1902, 3478.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1778, 'Steve Paul', 1902, 3487.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1779, 'Jasmine Beltran', 1902, 3496.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1780, 'Jonathan Glass MD', 1902, 3505.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1781, 'Monica Miller', 1902, 3514.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1782, 'Samantha Gardner', 1902, 3523.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1783, 'Bobby Guerrero', 1902, 3532.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1784, 'Lance Simmons', 1902, 3541.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1785, 'Heather Williams', 1902, 3550.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1786, 'Heather Bolton', 1902, 3559.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1787, 'William Gould', 1902, 3568.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1788, 'Mark Cox', 1902, 3577.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1789, 'Meghan Cisneros', 1902, 3586.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1790, 'Lawrence Harrington', 1902, 3595.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1791, 'Austin Osborne', 1902, 3604.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1792, 'James Bradley', 1902, 3613.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1793, 'Meghan Rush', 1902, 3622.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1794, 'Phillip Berry', 1902, 3631.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1795, 'Jennifer Banks', 1902, 3640.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1796, 'Brian Fitzgerald', 1902, 3649.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1797, 'Mr. Justin Green III', 1902, 3658.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1798, 'Zachary Mitchell', 1902, 3667.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1799, 'Katherine Martinez', 1902, 3676.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1800, 'Jodi Roach', 1902, 3685.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1801, 'Brandon Fleming', 1902, 3694.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1802, 'Emma Reed', 1902, 3703.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1803, 'Joshua Vance', 1902, 3712.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1804, 'Michelle Ho', 1902, 3721.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1805, 'Rebecca Hicks', 1902, 3730.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1806, 'Curtis Taylor', 1902, 3739.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1807, 'Allison Spencer', 1902, 3748.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1808, 'Robert Arnold', 1902, 3757.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1809, 'Angelica Parker', 1902, 3766.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1810, 'Dr. Kelly Hammond DVM', 1902, 3775.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1811, 'William Day', 1902, 3784.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1812, 'Michael Cooper', 1902, 3793.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1813, 'Penny Bowman', 1902, 3802.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1814, 'Vincent Reynolds', 1902, 3811.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1815, 'Amy Martinez', 1902, 3820.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1816, 'Christopher Morris', 1902, 3829.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1817, 'Hannah Everett', 1902, 3838.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1818, 'Sarah King', 1902, 3847.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1819, 'Krista Martinez', 1902, 3856.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1820, 'Joseph Shaw', 1902, 3865.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1821, 'Todd Moore', 1902, 3874.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1822, 'Michelle Jacobs', 1902, 3883.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1823, 'Kristy Bryan', 1902, 3892.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1824, 'Angel May', 1902, 3901.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1825, 'Marilyn Wang', 1902, 3910.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1826, 'Mark Jimenez', 1902, 3919.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1827, 'Donna Frye', 1902, 3928.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1828, 'Dr. Michael Evans', 1902, 3937.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1829, 'Anthony Gonzales', 1902, 3946.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1830, 'Mr. Lawrence Edwards', 1902, 3955.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1831, 'Morgan Valencia', 1902, 3964.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1832, 'Bianca Wood', 1902, 3973.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1833, 'Emma Owens', 1902, 3982.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1834, 'David Davis', 1902, 3991.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1835, 'James Gilbert', 1902, 4000.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1836, 'Sean Moore', 1902, 4009.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1837, 'Kenneth Edwards', 1902, 4018.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1838, 'Kathleen Robertson', 1902, 4027.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1839, 'Mr. Alexander Landry MD', 1902, 4036.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1840, 'Cindy Gomez', 1902, 4045.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1841, 'Johnny Khan', 1902, 4054.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1842, 'Julie Herrera', 1902, 4063.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1843, 'Jessica Khan', 1902, 4072.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1844, 'Pamela Diaz', 1902, 4081.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1845, 'Kelly Lee', 1902, 4090.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1846, 'Angel Gordon', 1902, 4099.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1847, 'Diana Hays', 1902, 4108.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1848, 'Barbara Hester', 1902, 4117.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1849, 'Robert Morgan', 1902, 4126.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1850, 'Nicole Gonzalez', 1902, 4135.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1851, 'Kathryn Williams', 1902, 4144.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1852, 'Gary Wells', 1902, 4153.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1853, 'Larry Robertson', 1902, 4162.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1854, 'Louis Martin', 1902, 4171.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1855, 'Nancy Evans MD', 1902, 4180.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1856, 'Kim Erickson', 1902, 4189.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1857, 'Robert Richardson', 1902, 4198.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1858, 'Veronica Silva', 1902, 4207.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1859, 'Molly Watts', 1902, 4216.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1860, 'John Coffey', 1902, 4225.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1861, 'Paula Lane', 1902, 4234.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1862, 'Lauren Jackson', 1902, 4243.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1863, 'Lisa Randall', 1902, 4252.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1864, 'Michael Johnson', 1902, 4261.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1865, 'Ashley Smith', 1902, 4270.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1866, 'Christian Vaughn', 1902, 4279.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1867, 'Reginald Knapp', 1902, 4288.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1868, 'Nancy Brown', 1902, 4297.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1869, 'Daniel Nguyen', 1902, 4306.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1870, 'Kelly Edwards', 1902, 4315.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1871, 'Thomas Peterson', 1902, 4324.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1872, 'Raymond Le', 1902, 4333.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1873, 'Melissa Bishop', 1902, 4342.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1874, 'David Grant', 1902, 4351.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1875, 'William Evans', 1902, 4360.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1876, 'Daniel Bush', 1902, 4369.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1877, 'Gregory Peck', 1902, 4378.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1878, 'Denise Martinez', 1902, 4387.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1879, 'Jamie Baird', 1902, 4396.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1880, 'Tina Ballard', 1902, 4405.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1881, 'Dwayne Klein', 1902, 4414.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1882, 'Jeremy Scott', 1902, 4423.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1883, 'Dale Ryan', 1902, 4432.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1884, 'Melissa Taylor', 1902, 4441.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1885, 'Laurie Sanchez', 1902, 4450.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1886, 'Kiara Little', 1902, 4459.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1887, 'Jason Love', 1902, 4468.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1888, 'Randy Smith', 1902, 4477.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1889, 'Tanya Russell', 1902, 4486.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1890, 'Sherry Woods', 1902, 4495.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1891, 'Victor Morris', 1902, 4504.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1892, 'Susan Davis', 1902, 4513.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1893, 'Kimberly Sharp', 1902, 4522.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1894, 'Susan Thompson', 1902, 4531.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1895, 'Casey Gillespie', 1902, 4540.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1896, 'Jennifer Simpson DVM', 1902, 4549.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1897, 'Tammy Mcdowell', 1902, 4558.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1898, 'Keith Rodriguez', 1902, 4567.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1899, 'Mrs. Virginia Daniels', 1902, 4576.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1900, 'Todd Rosales MD', 1902, 4585.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1901, 'Brian Martin', 1902, 4594.0, '205 Bradley Throughway Apt. 296
Robertsonland, MO 88221');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3404, 'Jose Townsend', NULL, 3705, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3405, 'Katie Tucker', NULL, 3714.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3406, 'Matthew Flores', NULL, 3723.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3407, 'Brendan Bonilla', NULL, 3732.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3408, 'Kim Sims', NULL, 3741.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3409, 'Mark Lewis', NULL, 3750.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3410, 'Sara Harris', NULL, 3759.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3411, 'Sherry Figueroa', NULL, 3768.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3412, 'Robert Jones', NULL, 3777.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3413, 'Allison Love', NULL, 3786.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3414, 'Benjamin Thompson', NULL, 3795.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3415, 'Benjamin Underwood', NULL, 3804.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3416, 'Jennifer Hayes', NULL, 3813.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3417, 'Eugene Price', NULL, 3822.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3418, 'Aaron Cortez', NULL, 3831.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3419, 'Patrick Williams', NULL, 3840.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3420, 'Heather Shaw', NULL, 3849.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3421, 'Michael Obrien', NULL, 3858.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3422, 'Timothy James', NULL, 3867.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3423, 'Amanda Moore', NULL, 3876.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3424, 'Paul Robles', NULL, 3885.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3425, 'Elizabeth Walters', NULL, 3894.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3426, 'Stephen Sanford', NULL, 3903.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3427, 'Maria Bernard', NULL, 3912.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3428, 'Shaun Thomas', NULL, 3921.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3429, 'Kenneth Long', NULL, 3930.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3430, 'Angela Clark', NULL, 3939.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3431, 'Molly Lewis', NULL, 3948.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3432, 'Sarah Thomas', NULL, 3957.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3433, 'Luis King', NULL, 3966.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3434, 'Michael Bradley', NULL, 3975.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3435, 'Paul Branch', NULL, 3984.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3436, 'Danielle Gonzalez', NULL, 3993.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3437, 'Tiffany Howard', NULL, 4002.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3438, 'Cynthia Mitchell', NULL, 4011.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3439, 'Corey Tucker', NULL, 4020.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3440, 'Matthew Steele', NULL, 4029.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3441, 'Keith Aguirre', NULL, 4038.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3442, 'Caroline Edwards', NULL, 4047.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3443, 'Michelle Davidson', NULL, 4056.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3444, 'Ian Frazier', NULL, 4065.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3445, 'John Griffin', NULL, 4074.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3446, 'Katelyn Rodriguez', NULL, 4083.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3447, 'Angela Ramirez', NULL, 4092.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3448, 'Stephanie Gonzalez', NULL, 4101.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3449, 'Lori Luna', NULL, 4110.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3450, 'Sarah Welch', NULL, 4119.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3451, 'Lauren Hammond', NULL, 4128.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3452, 'Andrew Green', NULL, 4137.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3453, 'Kimberly Valdez', NULL, 4146.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3454, 'James Vance', NULL, 4155.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3455, 'Shannon Anderson', NULL, 4164.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3456, 'Ann Cox', NULL, 4173.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3457, 'David Maynard', NULL, 4182.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3458, 'Miss Nicole Taylor', NULL, 4191.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3459, 'Keith Knight', NULL, 4200.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3460, 'Brianna Dennis', NULL, 4209.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3461, 'Amanda Juarez', NULL, 4218.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3462, 'Dennis Young', NULL, 4227.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3463, 'Kelly Moody', NULL, 4236.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3464, 'Thomas Keith', NULL, 4245.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3465, 'Matthew Garcia', NULL, 4254.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3466, 'Madeline Hill', NULL, 4263.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3467, 'Lauren Hudson', NULL, 4272.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3468, 'James Matthews', NULL, 4281.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3469, 'Angela King', NULL, 4290.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3470, 'Courtney Sullivan', NULL, 4299.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3471, 'Haley Sparks', NULL, 4308.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3472, 'Adriana Macias', NULL, 4317.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3473, 'David Robertson', NULL, 4326.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3474, 'Chris Moore', NULL, 4335.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3475, 'Ruth Guerrero', NULL, 4344.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3476, 'Gary Wilson', NULL, 4353.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3477, 'Karen Garza', NULL, 4362.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3478, 'Jennifer Sanchez', NULL, 4371.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3479, 'Kevin Taylor', NULL, 4380.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3480, 'Stephanie Thomas', NULL, 4389.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3481, 'Thomas Black', NULL, 4398.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3482, 'Wayne Walsh', NULL, 4407.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3483, 'Monica Nicholson', NULL, 4416.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3484, 'Claire Obrien', NULL, 4425.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3485, 'John Robinson', NULL, 4434.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3486, 'Charles Aguilar', NULL, 4443.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3487, 'Lisa Dixon', NULL, 4452.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3488, 'Michael Nielsen', NULL, 4461.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3489, 'Andrea Gray', NULL, 4470.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3490, 'Alan Mills', NULL, 4479.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3491, 'Melinda Serrano', NULL, 4488.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3492, 'Cassandra Valenzuela', NULL, 4497.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3493, 'Sherry Schmidt', NULL, 4506.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3494, 'Anna Hopkins', NULL, 4515.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3495, 'Kimberly Smith', NULL, 4524.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3496, 'Meghan Reynolds', NULL, 4533.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3497, 'Shaun Wolfe', NULL, 4542.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3498, 'Todd Olson', NULL, 4551.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3499, 'Hayley Ballard', NULL, 4560.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3500, 'Sara Johnston', NULL, 4569.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3501, 'David Cannon', NULL, 4578.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3502, 'Angela George', NULL, 4587.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3503, 'Deanna Smith', NULL, 4596.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3504, 'Adrienne Mills', NULL, 4605.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3505, 'Jaime Harris', NULL, 4614.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3506, 'Jennifer Rodriguez', NULL, 4623.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3507, 'Kevin Green', NULL, 4632.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3508, 'Krystal Carr', NULL, 4641.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3509, 'Jennifer Harris DDS', NULL, 4650.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3510, 'Cassandra Hansen', NULL, 4659.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3511, 'Dr. Kenneth Schroeder', NULL, 4668.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3512, 'Charles Shields', NULL, 4677.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3513, 'David Logan', NULL, 4686.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3514, 'Ariel Romero', NULL, 4695.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3515, 'Rebecca Mendez', NULL, 4704.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3516, 'Amy Price', NULL, 4713.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3517, 'Regina Morrow', NULL, 4722.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3518, 'Kyle Davis', NULL, 4731.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3519, 'Jacob Lynch', NULL, 4740.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3520, 'Tara Morales', NULL, 4749.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3521, 'Donna Stuart', NULL, 4758.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3522, 'Raymond Thompson', NULL, 4767.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3523, 'Adam Jefferson DVM', NULL, 4776.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3524, 'Chloe Bowers', NULL, 4785.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3525, 'Melissa Gilbert', NULL, 4794.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3526, 'Heather Pena', NULL, 4803.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3527, 'Angie Hill', NULL, 4812.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3528, 'Michael Sullivan', NULL, 4821.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3529, 'Adrian Padilla', NULL, 4830.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3530, 'Krista Barber', NULL, 4839.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3531, 'Lauren Bailey', NULL, 4848.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3532, 'Courtney Mccarty', NULL, 4857.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3533, 'Jared Smith', NULL, 4866.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3534, 'Jonathan Hansen', NULL, 4875.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3535, 'Gina Wilson', NULL, 4884.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3536, 'Deanna Medina', NULL, 4893.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3537, 'Danielle Ramos', NULL, 4902.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3538, 'John Sanchez', NULL, 4911.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3539, 'Reginald Maldonado', NULL, 4920.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3540, 'Shannon Olson', NULL, 4929.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3541, 'James Kramer', NULL, 4938.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3542, 'Michael Mcbride', NULL, 4947.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3543, 'Harry Nichols', NULL, 4956.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3544, 'Deborah Mitchell', NULL, 4965.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3545, 'Paul Peterson', NULL, 4974.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3546, 'Cassandra Edwards', NULL, 4983.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3547, 'Kenneth White', NULL, 4992.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3548, 'Tara Lee', NULL, 5001.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3549, 'Cynthia Allen', NULL, 5010.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3550, 'Daryl Conley', NULL, 5019.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3551, 'Heather Maxwell', NULL, 5028.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3552, 'Blake Sosa', NULL, 5037.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3553, 'Aaron Vincent DVM', NULL, 5046.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3554, 'Jacqueline Stewart', NULL, 5055.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3555, 'Sierra Andrews', NULL, 5064.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3556, 'Clayton Duran', NULL, 5073.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3557, 'Jennifer Christensen', NULL, 5082.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3558, 'Joseph Henderson', NULL, 5091.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3559, 'Amanda Reed', NULL, 5100.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3560, 'Patty Bryant', NULL, 5109.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3561, 'Joseph Stewart', NULL, 5118.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3562, 'Michael Gray', NULL, 5127.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3563, 'Isaiah Hensley', NULL, 5136.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3564, 'Dennis Adams', NULL, 5145.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3565, 'Grace White', NULL, 5154.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3566, 'Jason Goodwin', NULL, 5163.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3567, 'James Hayes', NULL, 5172.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3568, 'Veronica Parks', NULL, 5181.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3569, 'Michelle Brock', NULL, 5190.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3570, 'Selena Gonzalez', NULL, 5199.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3571, 'Nancy Kennedy', NULL, 5208.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3572, 'Javier Taylor', NULL, 5217.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3573, 'Lydia Ferguson', NULL, 5226.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3574, 'John King', NULL, 5235.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3575, 'Amber Garcia', NULL, 5244.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3576, 'Daniel King', NULL, 5253.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3577, 'Anne Garner', NULL, 5262.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3578, 'Isaac Grant', NULL, 5271.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3579, 'Hailey Jenkins', NULL, 5280.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3580, 'Michael Jacobs', NULL, 5289.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3581, 'Marie Ryan', NULL, 5298.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3582, 'Dominique Nguyen', NULL, 5307.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3583, 'Patricia Griffin', NULL, 5316.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3584, 'Louis Ford', NULL, 5325.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3585, 'Sheena Davidson', NULL, 5334.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3586, 'Jennifer Salazar', NULL, 5343.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3587, 'Terry Miller', NULL, 5352.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3588, 'Erik Delgado', NULL, 5361.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3589, 'Lisa Foster', NULL, 5370.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3590, 'Priscilla Mcmillan', NULL, 5379.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3591, 'Kelly Cole', NULL, 5388.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3592, 'Scott Martinez', NULL, 5397.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3593, 'David Manning', NULL, 5406.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3594, 'Christine Sanders', NULL, 5415.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3595, 'Timothy Kennedy', NULL, 5424.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3596, 'Randy Warren', NULL, 5433.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3597, 'Ashley Montgomery MD', NULL, 5442.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3598, 'Jean Perez', NULL, 5451.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3599, 'Jessica Martinez', NULL, 5460.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3600, 'Carolyn Johnson', NULL, 5469.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3601, 'Thomas Lin', NULL, 5478.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3602, 'Seth Donovan', NULL, 5487.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3603, 'Brandy Fry', NULL, 5496.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3604, 'Leslie Bryant', NULL, 5505.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3605, 'Sherry Graham', NULL, 5514.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3606, 'Kimberly Stout', NULL, 5523.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3607, 'Mr. Brandon Parker', NULL, 5532.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3608, 'Christopher Smith', NULL, 5541.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3609, 'Olivia Taylor', NULL, 5550.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3610, 'Joseph Watts', NULL, 5559.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3611, 'Pedro Evans DDS', NULL, 5568.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3612, 'Linda Robles', NULL, 5577.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3613, 'Chelsea Khan', NULL, 5586.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3614, 'David Espinoza', NULL, 5595.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3615, 'Sandra Walker', NULL, 5604.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3616, 'Mario Black', NULL, 5613.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3617, 'Lisa Benson', NULL, 5622.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3618, 'Matthew Patel', NULL, 5631.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3619, 'Cole Jones', NULL, 5640.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3620, 'Brian Gibson', NULL, 5649.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3621, 'Michael Vasquez', NULL, 5658.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3622, 'Christian Booker', NULL, 5667.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3623, 'William Campbell', NULL, 5676.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3624, 'Jeffrey Smith', NULL, 5685.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3625, 'Adrian Robinson', NULL, 5694.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3626, 'Richard Jimenez', NULL, 5703.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3627, 'Paul Thomas', NULL, 5712.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3628, 'James Daniels', NULL, 5721.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3629, 'Steven Wright', NULL, 5730.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3630, 'Adam Villegas', NULL, 5739.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3631, 'Janice Proctor', NULL, 5748.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3632, 'Anna Wade', NULL, 5757.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3633, 'James Ali', NULL, 5766.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3634, 'Caitlin Chandler', NULL, 5775.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3635, 'Mr. Isaac Williams', NULL, 5784.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3636, 'Valerie Young', NULL, 5793.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3637, 'Adrian Bauer', NULL, 5802.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3638, 'Lauren Vazquez', NULL, 5811.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3639, 'Brittney Townsend', NULL, 5820.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3640, 'Jonathan Parks', NULL, 5829.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3641, 'Wayne Malone', NULL, 5838.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3642, 'Henry Moore', NULL, 5847.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3643, 'Ashley Freeman', NULL, 5856.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3644, 'Justin Newman', NULL, 5865.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3645, 'Steven Quinn', NULL, 5874.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3646, 'James Ramsey', NULL, 5883.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3647, 'Andrew Mann', NULL, 5892.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3648, 'Kimberly Henry', NULL, 5901.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3649, 'Kimberly Morris', NULL, 5910.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3650, 'Sean George', NULL, 5919.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3651, 'Caitlyn Schmidt', NULL, 5928.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3652, 'Robert Weaver', NULL, 5937.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3653, 'Ricardo Hunter', NULL, 5946.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3654, 'Sonya Harvey', NULL, 5955.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3655, 'Manuel Flores', NULL, 5964.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3656, 'Walter Fuentes', NULL, 5973.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3657, 'Michael Cannon', NULL, 5982.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3658, 'Douglas Ortiz', NULL, 5991.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3659, 'Brent Hopkins', NULL, 6000.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3660, 'Brian Lee', NULL, 6009.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3661, 'Martin Price', NULL, 6018.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3662, 'Marcus Garza Jr.', NULL, 6027.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3663, 'Mitchell Smith', NULL, 6036.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3664, 'Mary Hebert', NULL, 6045.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3665, 'Julie Fowler', NULL, 6054.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3666, 'Patrick Zamora', NULL, 6063.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3667, 'Rebecca Brown', NULL, 6072.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3668, 'Kendra Navarro', NULL, 6081.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3669, 'Angela Lewis', NULL, 6090.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3670, 'Corey Sandoval', NULL, 6099.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3671, 'Theresa Hansen', NULL, 6108.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3672, 'Nichole Miranda', NULL, 6117.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3673, 'Megan Park', NULL, 6126.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3674, 'Brian Sparks', NULL, 6135.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3675, 'Kathy Sandoval', NULL, 6144.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3676, 'Lindsay Mahoney', NULL, 6153.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3677, 'Krista Shea', NULL, 6162.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3678, 'Jennifer Schultz', NULL, 6171.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3679, 'Erica Allen', NULL, 6180.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3680, 'Jaime Pierce', NULL, 6189.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3681, 'Heather Chavez', NULL, 6198.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3682, 'April Johnson', NULL, 6207.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3683, 'Alan Taylor', NULL, 6216.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3684, 'Abigail Joyce', NULL, 6225.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3685, 'Ethan Ingram', NULL, 6234.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3686, 'Samantha Ellison', NULL, 6243.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3687, 'Laura Duncan', NULL, 6252.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3688, 'Joe Moore', NULL, 6261.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3689, 'Steve Wright', NULL, 6270.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3690, 'Eric Duncan', NULL, 6279.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3691, 'Claudia Jones', NULL, 6288.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3692, 'John Freeman', NULL, 6297.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3693, 'Michele Weiss', NULL, 6306.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3694, 'Martin Johnson', NULL, 6315.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3695, 'Jane Deleon', NULL, 6324.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3696, 'Felicia Hobbs', NULL, 6333.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3697, 'Timothy Martinez', NULL, 6342.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3698, 'Nicole Atkinson', NULL, 6351.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3699, 'Madison Chen', NULL, 6360.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3700, 'Joseph Flores', NULL, 6369.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3701, 'Erin Wolfe', NULL, 6378.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3702, 'Michael Osborn', NULL, 6387.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3703, 'Nicole Johnston', NULL, 6396.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4005, 'Mr. James Duncan', 4305, 4306, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4006, 'Yolanda Warren', 4305, 4315.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4007, 'Derek Jordan', 4305, 4324.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4008, 'Laura Rodriguez', 4305, 4333.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4009, 'Jacob Lee', 4305, 4342.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4010, 'Matthew Carrillo', 4305, 4351.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4011, 'Gregory Underwood', 4305, 4360.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4012, 'Lisa Alexander', 4305, 4369.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4013, 'Cynthia Jennings', 4305, 4378.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4014, 'Nicholas Miller', 4305, 4387.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4015, 'Dana Oliver', 4305, 4396.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4016, 'Ronnie Roberts', 4305, 4405.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4017, 'Gary Singh', 4305, 4414.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4018, 'Joshua Christensen', 4305, 4423.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4019, 'Lisa Gay', 4305, 4432.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4020, 'Mary Bennett', 4305, 4441.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4021, 'Kelsey Scott', 4305, 4450.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4022, 'Curtis Horton', 4305, 4459.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4023, 'John Landry', 4305, 4468.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4024, 'Matthew Alvarado', 4305, 4477.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4025, 'Heather Rodriguez', 4305, 4486.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4026, 'Stephen Hughes', 4305, 4495.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4027, 'Katie Mckinney', 4305, 4504.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4028, 'Kari Harper', 4305, 4513.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4029, 'Cristian Rasmussen', 4305, 4522.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4030, 'Michelle Williams', 4305, 4531.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4031, 'Elizabeth Burns', 4305, 4540.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4032, 'Alicia Sutton', 4305, 4549.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4033, 'Eric Ferrell', 4305, 4558.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4034, 'Desiree Brown', 4305, 4567.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4035, 'James Cooke', 4305, 4576.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4036, 'Terry Avery MD', 4305, 4585.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4037, 'James Taylor', 4305, 4594.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4038, 'Kelly Gregory', 4305, 4603.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4039, 'Melissa Butler', 4305, 4612.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4040, 'Jessica Edwards', 4305, 4621.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4041, 'Joann Anderson', 4305, 4630.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4042, 'Lauren Sutton', 4305, 4639.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4043, 'Charles Barker', 4305, 4648.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4044, 'Susan Jordan', 4305, 4657.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4045, 'Patricia Douglas', 4305, 4666.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4046, 'Brooke Jones', 4305, 4675.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4047, 'Michelle White', 4305, 4684.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4048, 'Brianna Johnson', 4305, 4693.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4049, 'William Ali', 4305, 4702.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4050, 'Patrick Underwood', 4305, 4711.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4051, 'Nancy Hernandez', 4305, 4720.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4052, 'Carlos Johnson', 4305, 4729.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4053, 'Miss Lisa Salazar', 4305, 4738.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4054, 'Crystal Johnson', 4305, 4747.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4055, 'Richard Anderson', 4305, 4756.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4056, 'Julie Banks', 4305, 4765.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4057, 'James Wells', 4305, 4774.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4058, 'Darrell Ortiz', 4305, 4783.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4059, 'Tammy Clements', 4305, 4792.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4060, 'Michael Harris', 4305, 4801.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4061, 'Christopher Blevins', 4305, 4810.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4062, 'Luis Watts', 4305, 4819.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4063, 'Stacy Patterson', 4305, 4828.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4064, 'Lisa Holloway', 4305, 4837.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4065, 'Jennifer Crosby', 4305, 4846.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4066, 'Kimberly Davidson', 4305, 4855.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4067, 'Amanda Rodriguez', 4305, 4864.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4068, 'Shawn Rich', 4305, 4873.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4069, 'Joshua Terrell', 4305, 4882.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4070, 'James Hubbard', 4305, 4891.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4071, 'Cheryl Gonzales', 4305, 4900.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4072, 'Patricia Mitchell', 4305, 4909.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4073, 'Edward Ellison', 4305, 4918.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4074, 'Stephanie Ford', 4305, 4927.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4075, 'Ann Mason', 4305, 4936.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4076, 'Kevin Shannon', 4305, 4945.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4077, 'Jenna Morris', 4305, 4954.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4078, 'Jesse Mosley', 4305, 4963.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4079, 'Sonya Davis', 4305, 4972.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4080, 'Matthew Dawson', 4305, 4981.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4081, 'Nicholas Davis', 4305, 4990.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4082, 'Madison Miller', 4305, 4999.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4083, 'Monica Hester', 4305, 5008.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4084, 'Caitlin Pierce', 4305, 5017.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4085, 'Christopher Rogers', 4305, 5026.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4086, 'Shari Martin', 4305, 5035.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4087, 'Randy Williams', 4305, 5044.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4088, 'Nicholas Woodward', 4305, 5053.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4089, 'Christopher Roach', 4305, 5062.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4090, 'April Cannon', 4305, 5071.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4091, 'Jonathan Jimenez', 4305, 5080.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4092, 'Lisa Snyder', 4305, 5089.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4093, 'Matthew Chavez', 4305, 5098.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4094, 'Kyle Smith', 4305, 5107.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4095, 'Diana Fuller', 4305, 5116.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4096, 'Christine Lopez', 4305, 5125.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4097, 'Gregory Thomas', 4305, 5134.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4098, 'Kenneth Morrison', 4305, 5143.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4099, 'Brandon Rodriguez', 4305, 5152.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4100, 'Candace Mitchell DDS', 4305, 5161.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4101, 'Laura Hart', 4305, 5170.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4102, 'Nicole Ward', 4305, 5179.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4103, 'Randy Morris', 4305, 5188.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4104, 'Samantha Chang', 4305, 5197.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4105, 'Ana Ruiz', 4305, 5206.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4106, 'Scott Murphy', 4305, 5215.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4107, 'Daniel Clark', 4305, 5224.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4108, 'Kenneth Krause', 4305, 5233.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4109, 'Anita Ramsey', 4305, 5242.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4110, 'Rachel Mann', 4305, 5251.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4111, 'Ryan Green', 4305, 5260.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4112, 'Lisa Ho', 4305, 5269.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4113, 'Kathleen Daniel', 4305, 5278.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4114, 'Dr. Stephen Hall IV', 4305, 5287.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4115, 'Bruce Marshall', 4305, 5296.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4116, 'Nancy Clark', 4305, 5305.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4117, 'Robert Lewis', 4305, 5314.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4118, 'Melissa King', 4305, 5323.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4119, 'Eric Pierce', 4305, 5332.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4120, 'Ashley Cook', 4305, 5341.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4121, 'Keith Choi', 4305, 5350.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4122, 'Cheyenne Bass', 4305, 5359.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4123, 'Karen Wells', 4305, 5368.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4124, 'Chad Moore', 4305, 5377.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4125, 'Sean Huang', 4305, 5386.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4126, 'Robert Reilly', 4305, 5395.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4127, 'Joseph Cunningham', 4305, 5404.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4128, 'Kristen Smith', 4305, 5413.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4129, 'Evelyn Hendricks', 4305, 5422.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4130, 'Andrea Hernandez', 4305, 5431.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4131, 'Gina Brooks', 4305, 5440.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4132, 'Carol Obrien', 4305, 5449.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4133, 'Bruce Patton', 4305, 5458.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4134, 'Scott Mckinney', 4305, 5467.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4135, 'Brandon Wiley', 4305, 5476.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4136, 'Ronald Turner', 4305, 5485.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4137, 'Carrie Brooks', 4305, 5494.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4138, 'Dale Davis', 4305, 5503.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4139, 'Rebecca Stein', 4305, 5512.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4140, 'Gerald Webb', 4305, 5521.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4141, 'Emily Murphy', 4305, 5530.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4142, 'Annette Hendrix', 4305, 5539.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4143, 'Wendy Harris', 4305, 5548.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4144, 'James Hancock', 4305, 5557.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4145, 'Shelby Cook', 4305, 5566.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4146, 'Ashley Miranda', 4305, 5575.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4147, 'Alison Blake', 4305, 5584.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4148, 'Christine Gonzalez', 4305, 5593.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4149, 'Joseph Mejia', 4305, 5602.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4150, 'Denise Moore', 4305, 5611.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4151, 'Tyler Castro', 4305, 5620.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4152, 'Joshua Dunn', 4305, 5629.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4153, 'Tony Brock', 4305, 5638.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4154, 'Carolyn Collins', 4305, 5647.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4155, 'Kimberly Williams', 4305, 5656.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4156, 'Steven Williams', 4305, 5665.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4157, 'Brandon Myers', 4305, 5674.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4158, 'Stephanie Soto', 4305, 5683.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4159, 'Jill Kelly', 4305, 5692.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4160, 'Craig Chang', 4305, 5701.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4161, 'Angela Livingston', 4305, 5710.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4162, 'Laura Davis', 4305, 5719.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4163, 'Melissa Davis', 4305, 5728.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4164, 'Matthew Miranda', 4305, 5737.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4165, 'Travis Thomas', 4305, 5746.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4166, 'Deanna Cox', 4305, 5755.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4167, 'Thomas Rivera', 4305, 5764.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4168, 'Erika Freeman', 4305, 5773.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4169, 'Brian Mendoza', 4305, 5782.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4170, 'Diane Bailey', 4305, 5791.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4171, 'Katie Sullivan', 4305, 5800.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4172, 'Ashley Hawkins', 4305, 5809.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4173, 'Eric Murray', 4305, 5818.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4174, 'Cynthia Sanchez', 4305, 5827.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4175, 'John Jones', 4305, 5836.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4176, 'Michael Reynolds', 4305, 5845.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4177, 'Ms. Gloria Benson', 4305, 5854.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4178, 'Michael Stevenson', 4305, 5863.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4179, 'Sara Wilson', 4305, 5872.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4180, 'Erika Davis', 4305, 5881.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4181, 'Eric Sullivan', 4305, 5890.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4182, 'Melissa Carlson', 4305, 5899.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4183, 'Erin Newman', 4305, 5908.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4184, 'Daniel Taylor', 4305, 5917.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4185, 'Nicole Pacheco', 4305, 5926.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4186, 'Mary Chavez', 4305, 5935.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4187, 'Luis West', 4305, 5944.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4188, 'Shawn Evans', 4305, 5953.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4189, 'Meghan Sellers', 4305, 5962.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4190, 'Michelle Herman', 4305, 5971.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4191, 'Lauren Carr DDS', 4305, 5980.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4192, 'Sarah Brown', 4305, 5989.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4193, 'Tracy Smith', 4305, 5998.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4194, 'Veronica Rodriguez', 4305, 6007.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4195, 'Andre Reynolds', 4305, 6016.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4196, 'Lori Joseph', 4305, 6025.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4197, 'Jeffrey Clark', 4305, 6034.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4198, 'Charles Peters', 4305, 6043.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4199, 'Heather Butler', 4305, 6052.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4200, 'Shane Martinez', 4305, 6061.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4201, 'Matthew Thomas', 4305, 6070.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4202, 'Mary Proctor', 4305, 6079.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4203, 'Chad Shaffer', 4305, 6088.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4204, 'Stephanie Dominguez', 4305, 6097.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4205, 'Lisa Gibson', 4305, 6106.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4206, 'Robert Cruz', 4305, 6115.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4207, 'Jeff Smith', 4305, 6124.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4208, 'Dr. Michael Adams DVM', 4305, 6133.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4209, 'Amanda Johnson', 4305, 6142.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4210, 'Mr. Kevin Nixon', 4305, 6151.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4211, 'Nicholas Fox', 4305, 6160.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4212, 'Nicole Ramirez', 4305, 6169.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4213, 'Kelly Bishop', 4305, 6178.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4214, 'Mark Alvarado', 4305, 6187.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4215, 'Melinda Ryan', 4305, 6196.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4216, 'Lisa Berger', 4305, 6205.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4217, 'Alexandra Gibson', 4305, 6214.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4218, 'Laura Rivera', 4305, 6223.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4219, 'William Phillips', 4305, 6232.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4220, 'Michael Harper', 4305, 6241.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4221, 'Richard Green', 4305, 6250.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4222, 'Laura Berry', 4305, 6259.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4223, 'Dorothy Mclaughlin', 4305, 6268.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4224, 'John Martinez', 4305, 6277.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4225, 'Richard King', 4305, 6286.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4226, 'Denise Scott', 4305, 6295.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4227, 'Lindsey Kent', 4305, 6304.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4228, 'Mary Wood', 4305, 6313.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4229, 'Richard Young', 4305, 6322.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4230, 'Joseph Johnson', 4305, 6331.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4231, 'Dr. Linda Underwood', 4305, 6340.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4232, 'Nicole Gutierrez', 4305, 6349.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4233, 'Matthew Barber', 4305, 6358.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4234, 'Kenneth Wilkinson', 4305, 6367.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4235, 'Dennis Weiss', 4305, 6376.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4236, 'John Alvarez', 4305, 6385.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4237, 'Travis Nielsen', 4305, 6394.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4238, 'Michael Price', 4305, 6403.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4239, 'Joseph Graham', 4305, 6412.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4240, 'Robert Reyes', 4305, 6421.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4241, 'Joseph Blanchard', 4305, 6430.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4242, 'Joseph Gomez', 4305, 6439.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4243, 'Lisa Pearson', 4305, 6448.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4244, 'Devin Lang', 4305, 6457.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4245, 'Kevin Murray', 4305, 6466.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4246, 'Dana Powers', 4305, 6475.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4247, 'Kelly Byrd', 4305, 6484.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4248, 'Emily Smith MD', 4305, 6493.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4249, 'Jason Fox', 4305, 6502.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4250, 'Heather Hardy', 4305, 6511.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4251, 'Andrew Harvey', 4305, 6520.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4252, 'Kristopher Shannon', 4305, 6529.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4253, 'Kyle Martinez', 4305, 6538.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4254, 'Angelica Jacobs', 4305, 6547.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4255, 'Phillip Wong', 4305, 6556.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4256, 'Cathy Rodriguez', 4305, 6565.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4257, 'Edward Guerrero', 4305, 6574.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4258, 'Jesse Carney', 4305, 6583.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4259, 'Melissa Contreras', 4305, 6592.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4260, 'Dawn Norman', 4305, 6601.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4261, 'Antonio Price', 4305, 6610.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4262, 'Deanna Hess MD', 4305, 6619.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4263, 'William Gonzalez', 4305, 6628.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4264, 'Matthew Rodriguez', 4305, 6637.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4265, 'Jessica Mendez', 4305, 6646.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4266, 'Jeremy Green', 4305, 6655.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4267, 'Benjamin Luna', 4305, 6664.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4268, 'Alicia Jimenez', 4305, 6673.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4269, 'Christian Rivera', 4305, 6682.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4270, 'Aaron Zimmerman', 4305, 6691.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4271, 'Karen Powell', 4305, 6700.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4272, 'Robin Jones', 4305, 6709.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4273, 'James Norris', 4305, 6718.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4274, 'Barbara Nichols', 4305, 6727.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4275, 'Felicia Turner MD', 4305, 6736.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4276, 'Maria Diaz DVM', 4305, 6745.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4277, 'Ryan Hodges', 4305, 6754.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4278, 'Dale Spencer', 4305, 6763.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4279, 'Brian Barker', 4305, 6772.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4280, 'Dr. Jeffrey Lopez', 4305, 6781.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4281, 'Alexander Davies', 4305, 6790.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4282, 'James Sparks', 4305, 6799.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4283, 'Kathryn Hanna', 4305, 6808.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4284, 'George Le', 4305, 6817.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4285, 'Daniel Valdez', 4305, 6826.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4286, 'Teresa Berg', 4305, 6835.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4287, 'Natalie Hall', 4305, 6844.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4288, 'Nicolas Burns', 4305, 6853.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4289, 'Terry Montgomery', 4305, 6862.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4290, 'Summer Hoover', 4305, 6871.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4291, 'Logan Conley', 4305, 6880.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4292, 'Robert Wilson', 4305, 6889.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4293, 'Lisa Brown', 4305, 6898.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4294, 'George Huff', 4305, 6907.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4295, 'Jennifer Martinez', 4305, 6916.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4296, 'Cindy Williams', 4305, 6925.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4297, 'Arthur Hill', 4305, 6934.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4298, 'Carol Wood', 4305, 6943.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4299, 'David Perkins', 4305, 6952.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4300, 'Richard Chen', 4305, 6961.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4301, 'Christopher Hobbs', 4305, 6970.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4302, 'Adam Howe', 4305, 6979.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4303, 'Linda Campbell', 4305, 6988.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4304, 'Rebecca Alvarez', 4305, 6997.0, '6225 Thomas Summit Apt. 864
South Warrenberg, WV 18178');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LOCATION, openning_year, COUNT(*) AS n FROM cinema GROUP BY LOCATION, openning_year) WHERE (n = 300 OR n <> 1) ORDER BY LOCATION;

/*
Gold Result:
('205 Bradley Throughway Apt. 296\nRobertsonland, MO 88221',)
('6225 Thomas Summit Apt. 864\nSouth Warrenberg, WV 18178',)
('6225 Thomas Summit Apt. 864\nSouth Warrenberg, WV 18178',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema WHERE capacity > 300 GROUP BY LOCATION HAVING COUNT(*) > 1;

/*
Prediction Result:
('205 Bradley Throughway Apt. 296\nRobertsonland, MO 88221',)
('6225 Thomas Summit Apt. 864\nSouth Warrenberg, WV 18178',)
*/