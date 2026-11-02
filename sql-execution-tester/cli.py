import argparse
import os
from execution_tester import execution_test
from query_normalizer import normalize_sql

def read_input(input_val: str) -> str:
    """Read from file if it's a valid path, otherwise return the string itself."""
    if os.path.isfile(input_val):
        with open(input_val, 'r') as f:
            return f.read()
    return input_val

def main():
    parser = argparse.ArgumentParser(description="Test execution equivalence of two SQL queries.")
    parser.add_argument("--schema", required=True, help="Path to schema file or schema string")
    parser.add_argument("--dataset", required=True, help="Path to dataset file or dataset string")
    parser.add_argument("--gold_sql", required=True, help="Path to query 1 file or query 1 string")
    parser.add_argument("--prediction_sql", required=True, help="Path to query 2 file or query 2 string")
    parser.add_argument("--dialect", default="sqlite", choices=["sqlite", "postgres", "mysql"], help="SQL dialect to use for execution (sqlite, postgres, mysql)")

    parser.add_argument("--no-mock-time", action="store_true", help="Disable mocking of time functions (default is to mock time)")
    parser.add_argument("--sleep-time", type=float, default=0.0, help="Time to sleep in seconds between executing the two queries (default: 0.0)")

    args = parser.parse_args()

    # Determine inputs
    schema = read_input(args.schema)
    dataset = read_input(args.dataset)
    query1 = read_input(args.gold_sql)
    query2 = read_input(args.prediction_sql)

    mock_time = not args.no_mock_time

    try:
        norm_q1 = normalize_sql(query1, schema, dialect=args.dialect, mock_time=mock_time)
        norm_q2 = normalize_sql(query2, schema, dialect=args.dialect, mock_time=mock_time)
        result = execution_test(schema, dataset, norm_q1, norm_q2, sleep_time=args.sleep_time, dialect=args.dialect)
    except Exception as e:
        result = {"status": "ERROR_QUERY_EXECUTION", "error_message": str(e)}
    
    import json
    print(json.dumps(result, default=str))

if __name__ == "__main__":
    main()
