import os
import sys
import time
import csv

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "src")))
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "sql-execution-tester")))

from parser import parse_ddl_to_schema, parse_sql_to_ast
from dataset_generator import generate_base_dataset, ensure_dataset_uniqueness
from dataset_generator.augmentation import repair_orphan_rows
from dataset_generator.value_generator import DataFactory
from sql_serializer import generate_inserts
from models import Dataset
from execution_tester import execution_test

SCHEMA = """
CREATE TABLE NATION (
  N_NATIONKEY INTEGER PRIMARY KEY NOT NULL,
  N_NAME      TEXT NOT NULL,
  N_REGIONKEY INTEGER NOT NULL,
  N_COMMENT   TEXT,
  FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY)
);

CREATE TABLE REGION (
  R_REGIONKEY INTEGER PRIMARY KEY NOT NULL,
  R_NAME      TEXT NOT NULL,
  R_COMMENT   TEXT
);

CREATE TABLE PART (
  P_PARTKEY     INTEGER PRIMARY KEY NOT NULL,
  P_NAME        TEXT NOT NULL,
  P_MFGR        TEXT NOT NULL,
  P_BRAND       TEXT NOT NULL,
  P_TYPE        TEXT NOT NULL,
  P_SIZE        INTEGER NOT NULL,
  P_CONTAINER   TEXT NOT NULL,
  P_RETAILPRICE INTEGER NOT NULL,
  P_COMMENT     TEXT NOT NULL
);

CREATE TABLE SUPPLIER (
  S_SUPPKEY   INTEGER PRIMARY KEY NOT NULL,
  S_NAME      TEXT NOT NULL,
  S_ADDRESS   TEXT NOT NULL,
  S_NATIONKEY INTEGER NOT NULL,
  S_PHONE     TEXT NOT NULL,
  S_ACCTBAL   INTEGER NOT NULL,
  S_COMMENT   TEXT NOT NULL,
  FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY)
);

CREATE TABLE PARTSUPP (
  PS_PARTKEY    INTEGER NOT NULL,
  PS_SUPPKEY    INTEGER NOT NULL,
  PS_AVAILQTY   INTEGER NOT NULL,
  PS_SUPPLYCOST INTEGER NOT NULL,
  PS_COMMENT    TEXT NOT NULL,
  PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY),
  FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY),
  FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY)
);

CREATE TABLE CUSTOMER (
  C_CUSTKEY    INTEGER PRIMARY KEY NOT NULL,
  C_NAME       TEXT NOT NULL,
  C_ADDRESS    TEXT NOT NULL,
  C_NATIONKEY  INTEGER NOT NULL,
  C_PHONE      TEXT NOT NULL,
  C_ACCTBAL    INTEGER   NOT NULL,
  C_MKTSEGMENT TEXT NOT NULL,
  C_COMMENT    TEXT NOT NULL,
  FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY)
);

CREATE TABLE ORDERS (
  O_ORDERKEY      INTEGER PRIMARY KEY NOT NULL,
  O_CUSTKEY       INTEGER NOT NULL,
  O_ORDERSTATUS   TEXT NOT NULL,
  O_TOTALPRICE    INTEGER NOT NULL,
  O_ORDERDATE     DATE NOT NULL,
  O_ORDERPRIORITY TEXT NOT NULL,  
  O_CLERK         TEXT NOT NULL, 
  O_SHIPPRIORITY  INTEGER NOT NULL,
  O_COMMENT       TEXT NOT NULL,
  FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY)
);

CREATE TABLE LINEITEM (
  L_ORDERKEY      INTEGER NOT NULL,
  L_PARTKEY       INTEGER NOT NULL,
  L_SUPPKEY       INTEGER NOT NULL,
  L_LINENUMBER    INTEGER NOT NULL,
  L_QUANTITY      INTEGER NOT NULL,
  L_EXTENDEDPRICE INTEGER NOT NULL,
  L_DISCOUNT      INTEGER NOT NULL,
  L_TAX           INTEGER NOT NULL,
  L_RETURNFLAG    TEXT NOT NULL,
  L_LINESTATUS    TEXT NOT NULL,
  L_SHIPDATE      DATE NOT NULL,
  L_COMMITDATE    DATE NOT NULL,
  L_RECEIPTDATE   DATE NOT NULL,
  L_SHIPINSTRUCT  TEXT NOT NULL,
  L_SHIPMODE      TEXT NOT NULL,
  L_COMMENT       TEXT NOT NULL,
  PRIMARY KEY (L_ORDERKEY, L_LINENUMBER),
  FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY),
  FOREIGN KEY (L_PARTKEY, L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY, PS_SUPPKEY)
);
"""

QUERIES = {
    "Q01": "SELECT l_returnflag, l_linestatus, SUM(l_quantity) AS sum_qty, SUM(l_extendedprice) AS sum_base_price, SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price, SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge, AVG(l_quantity) AS avg_qty, AVG(l_extendedprice) AS avg_price, AVG(l_discount) AS avg_disc, COUNT(*) AS count_order FROM lineitem WHERE l_shipdate <= DATE('1998-12-01', '-104 DAY') GROUP BY l_returnflag, l_linestatus ORDER BY l_returnflag NULLS LAST, l_linestatus NULLS LAST LIMIT 1",
    "Q02": "SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment FROM part, supplier, partsupp, nation, region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = 41 AND p_type LIKE '%NICKEL' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'EUROPE' AND ps_supplycost = (SELECT MIN(ps_supplycost) FROM partsupp, supplier, nation, region WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'EUROPE') ORDER BY s_acctbal DESC NULLS FIRST, n_name NULLS LAST, s_name NULLS LAST, p_partkey NULLS LAST LIMIT 100",
    "Q03": "SELECT l_orderkey, SUM(l_extendedprice * (1 - l_discount)) AS revenue, o_orderdate, o_shippriority FROM customer, orders, lineitem WHERE c_mktsegment = 'MACHINERY' AND c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate < DATE('1995-03-25') AND l_shipdate > DATE('1995-03-25') GROUP BY l_orderkey, o_orderdate, o_shippriority ORDER BY revenue DESC NULLS FIRST, o_orderdate NULLS LAST LIMIT 10",
    "Q04": "SELECT o_orderpriority, COUNT(*) AS order_count FROM orders WHERE o_orderdate >= DATE('1996-11-01') AND o_orderdate < DATE(DATE('1996-11-01'), '+3 MONTH') AND EXISTS(SELECT * FROM lineitem WHERE l_orderkey = o_orderkey AND l_commitdate < l_receiptdate) GROUP BY o_orderpriority ORDER BY o_orderpriority NULLS LAST LIMIT 1",
    "Q05": "SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM customer, orders, lineitem, supplier, nation, region WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND l_suppkey = s_suppkey AND c_nationkey = s_nationkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AFRICA' AND o_orderdate >= DATE('1996-01-01') AND o_orderdate < DATE(DATE('1996-01-01'), '+1 YEAR') GROUP BY n_name ORDER BY revenue DESC NULLS FIRST LIMIT 1",
    "Q06": "SELECT SUM(l_extendedprice * l_discount) AS revenue FROM lineitem WHERE l_shipdate >= DATE('1996-01-01') AND l_shipdate < DATE(DATE('1996-01-01'), '+1 YEAR') AND l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01 AND l_quantity < 24 LIMIT 1",
    "Q07": "SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue FROM (SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, CAST(STRFTIME('%Y', l_shipdate) AS INTEGER) AS l_year, l_extendedprice * (1 - l_discount) AS volume FROM supplier, lineitem, orders, customer, nation AS n1, nation AS n2 WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey AND c_custkey = o_custkey AND s_nationkey = n1.n_nationkey AND c_nationkey = n2.n_nationkey AND ((n1.n_name = 'ETHIOPIA' AND n2.n_name = 'JAPAN') OR (n1.n_name = 'JAPAN' AND n2.n_name = 'ETHIOPIA')) AND l_shipdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31')) AS shipping GROUP BY supp_nation, cust_nation, l_year ORDER BY supp_nation NULLS LAST, cust_nation NULLS LAST, l_year NULLS LAST LIMIT 1",
    "Q08": "SELECT o_year, SUM(CASE WHEN nation = 'JAPAN' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share FROM (SELECT CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) AS volume, n2.n_name AS nation FROM part, supplier, lineitem, orders, customer, nation AS n1, nation AS n2, region WHERE p_partkey = l_partkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND r_name = 'ASIA' AND s_nationkey = n2.n_nationkey AND o_orderdate BETWEEN DATE('1995-01-01') AND DATE('1996-12-31') AND p_type = 'LARGE BRUSHED NICKEL') AS all_nations GROUP BY o_year ORDER BY o_year NULLS LAST LIMIT 1",
    "Q09": "SELECT nation, o_year, SUM(amount) AS sum_profit FROM (SELECT n_name AS nation, CAST(STRFTIME('%Y', o_orderdate) AS INTEGER) AS o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount FROM part, supplier, lineitem, partsupp, orders, nation WHERE s_suppkey = l_suppkey AND ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND p_partkey = l_partkey AND o_orderkey = l_orderkey AND s_nationkey = n_nationkey AND p_name LIKE '%orchid%') AS profit GROUP BY nation, o_year ORDER BY nation NULLS LAST, o_year DESC NULLS FIRST LIMIT 1",
    "Q10": "SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment FROM customer, orders, lineitem, nation WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey AND o_orderdate >= DATE('1994-11-01') AND o_orderdate < DATE(DATE('1994-11-01'), '+3 MONTH') AND l_returnflag = 'R' AND c_nationkey = n_nationkey GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment ORDER BY revenue DESC NULLS FIRST LIMIT 20",
    "Q11": "SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS value FROM partsupp, supplier, nation WHERE ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'ARGENTINA' GROUP BY ps_partkey HAVING SUM(ps_supplycost * ps_availqty) > (SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 FROM partsupp, supplier, nation WHERE ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'ARGENTINA') ORDER BY value DESC NULLS FIRST LIMIT 1",
    "Q12": "SELECT l_shipmode, SUM(CASE WHEN o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH' THEN 1 ELSE 0 END) AS high_line_count, SUM(CASE WHEN o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count FROM orders, lineitem WHERE o_orderkey = l_orderkey AND l_shipmode IN ('TRUCK', 'RAIL') AND l_commitdate < l_receiptdate AND l_shipdate < l_commitdate AND l_receiptdate >= DATE('1994-01-01') AND l_receiptdate < DATE(DATE('1994-01-01'), '+1 YEAR') GROUP BY l_shipmode ORDER BY l_shipmode NULLS LAST LIMIT 1",
    "Q13": "SELECT c_count, COUNT(*) AS custdist FROM (SELECT c_custkey, COUNT(o_orderkey) AS c_count FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%pending%packages%' GROUP BY c_custkey) AS c_orders GROUP BY c_count ORDER BY custdist DESC NULLS FIRST, c_count DESC NULLS FIRST LIMIT 1",
    "Q14": "SELECT 100.00 * SUM(CASE WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / SUM(l_extendedprice * (1 - l_discount)) AS promo_revenue FROM lineitem, part WHERE l_partkey = p_partkey AND l_shipdate >= DATE('1994-03-01') AND l_shipdate < DATE(DATE('1994-03-01'), '+1 MONTH') LIMIT 1",
    "Q15": "WITH revenue0 AS (SELECT l_suppkey AS supplier_no, SUM(l_extendedprice * (1 - l_discount)) AS total_revenue FROM lineitem WHERE l_shipdate >= DATE('1997-05-01') AND l_shipdate < DATE(DATE('1997-05-01'), '+3 MONTH') GROUP BY l_suppkey) SELECT s_suppkey, s_name, s_address, s_phone, total_revenue FROM supplier, revenue0 WHERE s_suppkey = supplier_no AND total_revenue = (SELECT MAX(total_revenue) FROM revenue0) ORDER BY s_suppkey NULLS LAST LIMIT 1",
    "Q16": "SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt FROM partsupp, part WHERE p_partkey = ps_partkey AND p_brand <> 'Brand#31' AND p_type NOT LIKE 'LARGE PLATED%' AND p_size IN (47, 31, 18, 19, 48, 7, 39, 22) AND NOT ps_suppkey IN (SELECT s_suppkey FROM supplier WHERE s_comment LIKE '%Customer%Complaints%') GROUP BY p_brand, p_type, p_size ORDER BY supplier_cnt DESC NULLS FIRST, p_brand NULLS LAST, p_type NULLS LAST, p_size NULLS LAST LIMIT 1",
    "Q17": "SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly FROM lineitem, part, (SELECT l_partkey AS agg_partkey, 0.2 * AVG(l_quantity) AS avg_quantity FROM lineitem GROUP BY l_partkey) AS part_agg WHERE p_partkey = l_partkey AND agg_partkey = l_partkey AND p_brand = 'Brand#13' AND p_container = 'WRAP PKG' AND l_quantity < avg_quantity LIMIT 1",
    "Q18": "SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) FROM customer, orders, lineitem WHERE o_orderkey IN (SELECT l_orderkey FROM lineitem GROUP BY l_orderkey HAVING SUM(l_quantity) > 314) AND c_custkey = o_custkey AND o_orderkey = l_orderkey GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice ORDER BY o_totalprice DESC NULLS FIRST, o_orderdate NULLS LAST LIMIT 100",
    "Q19": "SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue FROM lineitem, part WHERE (p_partkey = l_partkey AND p_brand = 'Brand#54' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND l_quantity >= 8 AND l_quantity <= 8 + 10 AND p_size BETWEEN 1 AND 5 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand#22' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND l_quantity >= 13 AND l_quantity <= 13 + 10 AND p_size BETWEEN 1 AND 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') OR (p_partkey = l_partkey AND p_brand = 'Brand#51' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND l_quantity >= 22 AND l_quantity <= 22 + 10 AND p_size BETWEEN 1 AND 15 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON') LIMIT 1",
    "Q20": "SELECT s_name, s_address FROM supplier, nation WHERE s_suppkey IN (SELECT ps_suppkey FROM partsupp, (SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity FROM lineitem WHERE l_shipdate >= DATE('1994-01-01') AND l_shipdate < DATE(DATE('1994-01-01'), '+1 YEAR') GROUP BY l_partkey, l_suppkey) AS agg_lineitem WHERE agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey AND ps_partkey IN (SELECT p_partkey FROM part WHERE p_name LIKE 'navajo%') AND ps_availqty > agg_quantity) AND s_nationkey = n_nationkey AND n_name = 'INDIA' ORDER BY s_name NULLS LAST LIMIT 1",
    "Q21": "SELECT s_name, COUNT(*) AS numwait FROM supplier, lineitem AS l1, orders, nation WHERE s_suppkey = l1.l_suppkey AND o_orderkey = l1.l_orderkey AND o_orderstatus = 'F' AND l1.l_receiptdate > l1.l_commitdate AND EXISTS(SELECT * FROM lineitem AS l2 WHERE l2.l_orderkey = l1.l_orderkey AND l2.l_suppkey <> l1.l_suppkey) AND NOT EXISTS(SELECT * FROM lineitem AS l3 WHERE l3.l_orderkey = l1.l_orderkey AND l3.l_suppkey <> l1.l_suppkey AND l3.l_receiptdate > l3.l_commitdate) AND s_nationkey = n_nationkey AND n_name = 'INDIA' GROUP BY s_name ORDER BY numwait DESC NULLS FIRST, s_name NULLS LAST LIMIT 100",
    "Q22": "SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal FROM (SELECT SUBSTRING(c_phone, 1, 2) AS cntrycode, c_acctbal FROM customer WHERE SUBSTRING(c_phone, 1, 2) IN ('28', '43', '22', '39', '31', '30', '41') AND c_acctbal > (SELECT AVG(c_acctbal) FROM customer WHERE c_acctbal > 0.00 AND SUBSTRING(c_phone, 1, 2) IN ('28', '43', '22', '39', '31', '30', '41')) AND NOT EXISTS(SELECT * FROM orders WHERE o_custkey = c_custkey)) AS custsale GROUP BY cntrycode ORDER BY cntrycode NULLS LAST LIMIT 1",
}

def main():
    schema = parse_ddl_to_schema(SCHEMA)
    total_start = time.perf_counter()
    passed = 0

    results_dir = os.path.join(os.path.dirname(__file__), "results")
    datasets_dir = os.path.join(results_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("=" * 60)
    print("LASSO TPC-H Base Test Data Generation & Non-Empty Execution")
    print("=" * 60)

    results_summary = {}

    for q_id, q_sql in sorted(QUERIES.items()):
        t0 = time.perf_counter()
        DataFactory.get_instance().reset(42)
        DataFactory.get_instance().clear_uniqueness()
        
        parsed_q = parse_sql_to_ast(q_sql)
        base_data = generate_base_dataset(schema, parsed_q)
        base_ds = Dataset(
            strategy_name="BaseDatasetStrategy",
            data=base_data,
            tags=["base_dataset"],
            description="Attempts to yield a non-empty result for the query."
        )
        base_ds.data = ensure_dataset_uniqueness(schema, base_ds.data)
        repair_orphan_rows(schema, base_ds.data)
        base_ds.insert_statements = generate_inserts(schema, base_ds)

        dataset_sql = "\n".join(base_ds.insert_statements)
        
        # Save base dataset SQL
        dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
        with open(dataset_file, "w", encoding="utf-8") as f:
            f.write(dataset_sql + "\n")

        res = execution_test(schema=SCHEMA, dataset=dataset_sql, gold_sql=q_sql, prediction_sql=q_sql, dialect="sqlite")
        
        gold_res = res.get("gold_sql_result")
        err = res.get("error_message")
        elapsed = time.perf_counter() - t0

        if err:
            status = "ERROR"
            row_count = 0
            print(f"{q_id}: [ERROR] {err} ({elapsed:.3f}s)", flush=True)
        elif gold_res and len(gold_res) > 0:
            status = "OK"
            row_count = len(gold_res)
            print(f"{q_id}: [OK] {row_count} row(s) ({elapsed:.3f}s)", flush=True)
            passed += 1
        else:
            status = "EMPTY"
            row_count = 0
            print(f"{q_id}: [EMPTY] 0 rows ({elapsed:.3f}s)", flush=True)

        results_summary[q_id] = {
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "dataset_file": f"datasets/{q_id}.sql",
            "num_insert_statements": len(base_ds.insert_statements),
            "error_message": err,
            "result_sample": [list(r) for r in gold_res[:5]] if gold_res else [],
        }

    total_time = time.perf_counter() - total_start
    print("=" * 60)
    print(f"Summary: {passed}/{len(QUERIES)} non-empty ({passed/len(QUERIES)*100:.1f}%) in {total_time:.2f}s")
    print(f"Saved results and base datasets to: {results_dir}")
    print("=" * 60)

    # Save results CSV
    results_csv_path = os.path.join(results_dir, "results.csv")
    with open(results_csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "query_id",
                "status",
                "row_count",
                "elapsed_seconds",
                "dataset_file",
                "num_insert_statements",
                "error_message",
            ],
        )
        writer.writeheader()
        for q_id, q_data in sorted(results_summary.items()):
            writer.writerow({
                "query_id": q_id,
                "status": q_data["status"],
                "row_count": q_data["row_count"],
                "elapsed_seconds": q_data["elapsed_seconds"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"] or "",
            })

if __name__ == "__main__":
    main()
