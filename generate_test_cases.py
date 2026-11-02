import os
import json

TEST_CASES_DIR = "test_cases"

def ensure_dir(path):
    if not os.path.exists(path):
        os.makedirs(path)

def write_test_case(category, test_id, schema, correct_query, errors):
    ensure_dir(os.path.join(TEST_CASES_DIR, category))
    file_path = os.path.join(TEST_CASES_DIR, category, f"gen_{test_id}.json")
    
    data = {
        "id": test_id,
        "schema": schema.strip(),
        "correct_query": correct_query.strip(),
        "expected_semantic_errors_to_be_caught": errors
    }
    
    with open(file_path, "w") as f:
        json.dump(data, f, indent=4)

def create_error(err_id, desc, query):
    return {
        "id": err_id,
        "description": desc,
        "query": query.strip()
    }

def generate_aggregation_test_cases():
    schema = """
    CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount DECIMAL, sale_date DATE);
    """
    
    write_test_case(
        "function", "agg_comprehensive", schema,
        "SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;",
        [
            create_error("agg_1", "Used SUM instead of COUNT", "SELECT category, SUM(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;"),
            create_error("agg_2", "Used COUNT instead of SUM", "SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;"),
            create_error("agg_3", "Used MAX instead of AVG", "SELECT category, COUNT(amount) AS c, SUM(amount) AS s, MAX(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;"),
            create_error("agg_4", "Used MIN instead of MAX", "SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MIN(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;"),
            create_error("agg_5", "Missing GROUP BY", "SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales;"),
            create_error("agg_6", "Grouped by wrong column", "SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY product_name;")
        ]
    )

def generate_value_format_test_cases():
    schema = """
    CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);
    """
    write_test_case(
        "value", "value_format_complex", schema,
        "SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;",
        [
            create_error("val_fmt_1", "Wrong date format MM/DD/YY", "SELECT name FROM course WHERE start_date > '01/01/23' AND enrollment > 30;"),
            create_error("val_fmt_2", "Wrong date format MM/DD/YYYY", "SELECT name FROM course WHERE start_date > '01/01/2023' AND enrollment > 30;"),
            create_error("val_fmt_3", "Wrong date format DD-MM-YYYY", "SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;"),
            create_error("val_fmt_4", "Treated numeric value as string", "SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > '30';"),
            create_error("val_fmt_5", "Value mismatch, wrong threshold", "SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 31;")
        ]
    )

def generate_condition_test_cases():
    schema = """
    CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);
    CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);
    CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade DECIMAL);
    """
    write_test_case(
        "condition", "condition_implicit_explicit", schema,
        "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND e.grade IS NOT NULL;",
        [
            create_error("cond_1", "Explicit condition mismatch (dept instead of course name)", "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'CS' AND e.grade IS NOT NULL;"),
            create_error("cond_2", "Missing implicit condition IS NOT NULL", "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database';"),
            create_error("cond_3", "Wrong explicit condition attribute", "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'Database' AND e.grade IS NOT NULL;"),
            create_error("cond_4", "Wrong implicit condition IS NULL", "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND e.grade IS NULL;"),
            create_error("cond_5", "Missing explicit condition", "SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE e.grade IS NOT NULL;")
        ]
    )

def generate_operator_test_cases():
    schema = """
    CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary DECIMAL, hire_date DATE, department TEXT);
    """
    write_test_case(
        "operator", "operator_exhaustive", schema,
        "SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';",
        [
            create_error("op_1", "Used > instead of >=", "SELECT name FROM employees WHERE salary > 50000 AND department = 'Engineering';"),
            create_error("op_2", "Used < instead of >=", "SELECT name FROM employees WHERE salary < 50000 AND department = 'Engineering';"),
            create_error("op_3", "Used <= instead of >=", "SELECT name FROM employees WHERE salary <= 50000 AND department = 'Engineering';"),
            create_error("op_4", "Used = instead of >=", "SELECT name FROM employees WHERE salary = 50000 AND department = 'Engineering';"),
            create_error("op_5", "Used != instead of >=", "SELECT name FROM employees WHERE salary != 50000 AND department = 'Engineering';"),
            create_error("op_6", "Used OR instead of AND", "SELECT name FROM employees WHERE salary >= 50000 OR department = 'Engineering';"),
            create_error("op_7", "Used != instead of =", "SELECT name FROM employees WHERE salary >= 50000 AND department != 'Engineering';"),
            create_error("op_8", "Used LIKE instead of =", "SELECT name FROM employees WHERE salary >= 50000 AND department LIKE 'Engineering';")
        ]
    )

def generate_function_test_cases():
    schema = """
    CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT);
    CREATE TABLE enrollment (course_id INTEGER, grade DECIMAL);
    """
    # SQLite does not support AVG in WHERE, it throws a syntax error.
    # To test semantic errors, we need valid SQL.
    # The paper's example had AVG in WHERE, which is invalid SQL.
    # We will include errors that are valid SQL but semantically wrong.
    write_test_case(
        "function", "function_having_vs_where", schema,
        "SELECT c.name, ROUND(AVG(e.grade), 2) FROM course c JOIN enrollment e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;",
        [
            create_error("func_1", "Missing ROUND", "SELECT c.name, AVG(e.grade) FROM course c JOIN enrollment e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;"),
            create_error("func_2", "Wrong ROUND precision", "SELECT c.name, ROUND(AVG(e.grade), 1) FROM course c JOIN enrollment e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;"),
            create_error("func_3", "Missing HAVING clause", "SELECT c.name, ROUND(AVG(e.grade), 2) FROM course c JOIN enrollment e ON c.id = e.course_id GROUP BY c.name;"),
            create_error("func_4", "Used SUM in HAVING instead of AVG", "SELECT c.name, ROUND(AVG(e.grade), 2) FROM course c JOIN enrollment e ON c.id = e.course_id GROUP BY c.name HAVING SUM(e.grade) > 85;")
        ]
    )

def generate_wild_queries():
    # Spider-494
    schema = """
    CREATE TABLE battle (id INTEGER PRIMARY KEY, name TEXT, date TEXT, result TEXT);
    """
    write_test_case(
        "wild_queries", "wild_spider_494", schema,
        "SELECT name, date, result FROM battle;",
        [
            create_error("wild_1", "Missing result column", "SELECT name, date FROM battle;"),
            create_error("wild_2", "Selected id instead of result", "SELECT name, date, id FROM battle;")
        ]
    )

    # Spider-555
    schema2 = """
    CREATE TABLE students (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, cell_mobile_number TEXT);
    """
    write_test_case(
        "wild_queries", "wild_spider_555", schema2,
        "SELECT cell_mobile_number FROM students WHERE first_name = 'Timmothy' AND last_name = 'Ward';",
        [
            create_error("wild_1", "Wrong case for string literals", "SELECT cell_mobile_number FROM students WHERE first_name = 'timmothy' AND last_name = 'ward';"),
            create_error("wild_2", "Wrong columns in condition", "SELECT cell_mobile_number FROM students WHERE last_name = 'Timmothy' AND first_name = 'Ward';")
        ]
    )

    # Spider-579
    schema3 = """
    CREATE TABLE Students (id INTEGER PRIMARY KEY, current_address_id INTEGER);
    """
    write_test_case(
        "wild_queries", "wild_spider_579", schema3,
        "SELECT DISTINCT current_address_id FROM Students;",
        [
            create_error("wild_1", "Used COUNT unnecessarily", "SELECT count(DISTINCT current_address_id) FROM Students;"),
            create_error("wild_2", "Missing DISTINCT", "SELECT current_address_id FROM Students;")
        ]
    )

    # Spider-773
    schema4 = """
    CREATE TABLE country (Code TEXT PRIMARY KEY, Name TEXT, Continent TEXT, SurfaceArea DECIMAL);
    """
    write_test_case(
        "wild_queries", "wild_spider_773", schema4,
        "SELECT Name FROM country WHERE SurfaceArea > (SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe');",
        [
            create_error("wild_1", "Used MIN instead of MAX in subquery (Spider-773)", "SELECT Name FROM country WHERE SurfaceArea > (SELECT MIN(SurfaceArea) FROM country WHERE Continent = 'Europe');"),
            create_error("wild_2", "Missing subquery, joined instead (invalid logic)", "SELECT c1.Name FROM country c1 JOIN country c2 ON c2.Continent = 'Europe' WHERE c1.SurfaceArea > c2.SurfaceArea;")
        ]
    )

    # BIRD-252
    schema5 = """
    CREATE TABLE atom (atomid TEXT PRIMARY KEY, element TEXT);
    CREATE TABLE connected (atomid TEXT, atom_id2 TEXT);
    """
    write_test_case(
        "wild_queries", "wild_bird_252", schema5,
        "SELECT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atomid = T2.atomid WHERE T1.element = 'pb';",
        [
            create_error("wild_1", "Selected unnecessary T2.atomid", "SELECT T2.atomid, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atomid = T2.atomid WHERE T1.element = 'pb';")
        ]
    )

    # BIRD-812
    schema6 = """
    CREATE TABLE colour (id INTEGER PRIMARY KEY, colour TEXT);
    CREATE TABLE superhero (id INTEGER PRIMARY KEY, full_name TEXT, superheroname TEXT, eyecolourid INTEGER);
    """
    write_test_case(
        "wild_queries", "wild_bird_812", schema6,
        "SELECT T1.full_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eyecolourid = T2.id WHERE T2.colour = 'Blue' LIMIT 5;",
        [
            create_error("wild_1", "Selected superheroname instead of full_name", "SELECT T1.superheroname FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eyecolourid = T2.id WHERE T2.colour = 'Blue' LIMIT 5;")
        ]
    )

    # BIRD-986
    schema7 = """
    CREATE TABLE races (raceId INTEGER PRIMARY KEY, name TEXT);
    CREATE TABLE lapTimes (raceId INTEGER, lap INTEGER, time DECIMAL, milliseconds INTEGER);
    """
    write_test_case(
        "wild_queries", "wild_bird_986", schema7,
        "SELECT T2.name FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T1.lap = 1 ORDER BY T1.time LIMIT 1;",
        [
            create_error("wild_1", "Selected milliseconds instead of name", "SELECT T1.milliseconds FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T1.lap = 1 ORDER BY T1.time LIMIT 1;")
        ]
    )

    # BIRD-1029
    schema8 = """
    CREATE TABLE Team (team_api_id INTEGER PRIMARY KEY, team_long_name TEXT);
    CREATE TABLE Team_Attributes (team_api_id INTEGER, buildUpPlaySpeed INTEGER, buildUpPlayDribbling INTEGER);
    """
    write_test_case(
        "wild_queries", "wild_bird_1029", schema8,
        "SELECT t1.buildUpPlaySpeed FROM Team_Attributes AS t1 INNER JOIN Team AS t2 ON t1.team_api_id = t2.team_api_id ORDER BY t1.buildUpPlaySpeed DESC LIMIT 4;",
        [
            create_error("wild_1", "Wrong order by attribute and ASC instead of DESC", "SELECT t1.buildUpPlaySpeed FROM Team_Attributes AS t1 INNER JOIN Team AS t2 ON t1.team_api_id = t2.team_api_id ORDER BY t1.buildUpPlayDribbling ASC LIMIT 4;")
        ]
    )

    # BIRD-1248
    schema9 = """
    CREATE TABLE Patient (ID INTEGER PRIMARY KEY, Birthday DATE);
    CREATE TABLE Laboratory (ID INTEGER, FG DECIMAL);
    """
    write_test_case(
        "wild_queries", "wild_bird_1248", schema9,
        "SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.FG < 150 OR T2.FG > 450) AND T1.Birthday > '1980-01-01';",
        [
            create_error("wild_1", "Incorrect logic (<= 150 OR >= 450) instead of (< 150 OR > 450)", "SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.FG <= 150 OR T2.FG >= 450) AND T1.Birthday > '1980-01-01';"),
            create_error("wild_2", "Used BETWEEN (normal level) instead of abnormal level", "SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.FG BETWEEN 150 AND 450 AND T1.Birthday > '1980-01-01';")
        ]
    )

def generate_join_test_cases():
    schema = """
    CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);
    CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount DECIMAL);
    """
    write_test_case(
        "join", "join_comprehensive", schema,
        "SELECT c.name, SUM(o.amount) FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id GROUP BY c.name;",
        [
            create_error("join_1", "LEFT JOIN instead of INNER JOIN", "SELECT c.name, SUM(o.amount) FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id GROUP BY c.name;"),
            create_error("join_2", "Missing join condition", "SELECT c.name, SUM(o.amount) FROM Customers c, Orders o GROUP BY c.name;"),
            create_error("join_3", "Wrong join condition", "SELECT c.name, SUM(o.amount) FROM Customers c INNER JOIN Orders o ON c.customer_id = o.order_id GROUP BY c.name;")
        ]
    )
    
def generate_clause_test_cases():
    schema = """
    CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price DECIMAL);
    """
    write_test_case(
        "clause", "clause_comprehensive", schema,
        "SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC LIMIT 5;",
        [
            create_error("clause_1", "Missing GROUP BY", "SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC LIMIT 5;"),
            create_error("clause_2", "Missing ORDER BY", "SELECT category, COUNT(*) FROM Products GROUP BY category LIMIT 5;"),
            create_error("clause_3", "Missing LIMIT", "SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC;"),
            create_error("clause_4", "Wrong ORDER BY direction", "SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) ASC LIMIT 5;")
        ]
    )

def main():
    generate_aggregation_test_cases()
    generate_value_format_test_cases()
    generate_condition_test_cases()
    generate_operator_test_cases()
    generate_function_test_cases()
    generate_wild_queries()
    generate_join_test_cases()
    generate_clause_test_cases()

if __name__ == "__main__":
    main()
