import os
import sys
import glob
import json
import argparse
import traceback
from test_runner import run_test_case

def main():
    parser = argparse.ArgumentParser(description="Run all SQL semantic mutation test cases.")
    parser.add_argument("--verbose", action="store_true", help="Show the full table of results")
    args = parser.parse_args()

    test_cases_dir = "test_cases"
    # Find all JSON files recursively inside test_cases directory
    json_files = []
    for root, dirs, files in os.walk(test_cases_dir):
        if "split" in root: # ignore the old split folder if it exists
            continue
        for file in files:
            if file.endswith(".json"):
                json_files.append(os.path.join(root, file))
                
    if not json_files:
        print(f"No JSON files found in {test_cases_dir} and its subdirectories.")
        return

    total_test_cases = 0
    total_errors_all = 0
    total_killed_all = 0
    total_datasets_all = 0
    total_gold_valid_cnt = 0
    total_mutants_valid_cnt = 0
    
    if args.verbose:
        print("=" * 102)
        print(f"{'Test Case ID':<45} | {'Base(G/P)':<15} | {'Caught':<10} | {'%':<6} | {'Datasets':<10}")
        print("=" * 102)
    
    for file_path in sorted(json_files):
        with open(file_path, "r") as f:
            data = json.load(f)
            
        tc = data if not isinstance(data, list) else data[0]
        
        try:
            result = run_test_case(tc, debug=False)
            
            tc_id = result.get("test_case_id", os.path.basename(file_path))
            total = result["total_mutants"]
            killed = len(result["killed"])
            num_datasets = result.get("num_datasets", 0)
            
            # Log empty results on base dataset
            if not result.get("gold_base_valid"):
                print(f"In test case '{file_path}', the correct query produces empty results on the base dataset.")
                
            mutant_base_valid = result.get("mutant_base_valid", {})
            for m_id, is_valid in mutant_base_valid.items():
                if not is_valid:
                    print(f"In test case '{file_path}', mutant '{m_id}' produces empty results on the base dataset.")
            
            # Log alive mutants
            alive = result.get("alive", [])
            if alive:
                print(f"In test case '{file_path}', the following mutations were not killed: {', '.join(alive)}")

            gold_valid = "Y" if result.get("gold_base_valid") else "N"
            mutants_valid_cnt = sum(1 for v in mutant_base_valid.values() if v)
            base_str = f"{gold_valid} / {mutants_valid_cnt}:{total}"
            
            if total > 0:
                pct = (killed / total) * 100
            else:
                pct = 0.0
                
            caught_str = f"{killed}/{total}"
            if args.verbose:
                print(f"{tc_id:<45} | {base_str:<15} | {caught_str:<10} | {pct:>5.1f}% | {num_datasets:<10}")
            
            total_test_cases += 1
            total_errors_all += total
            total_killed_all += killed
            total_datasets_all += num_datasets
            if result.get("gold_base_valid"):
                total_gold_valid_cnt += 1
            total_mutants_valid_cnt += mutants_valid_cnt
            
        except Exception as e:
            tc_id = tc.get('id', os.path.basename(file_path))
            if args.verbose:
                print(f"{tc_id:<45} | {'ERROR':<15} | {'ERROR':<10} | N/A    | N/A")
                print(f"  Error details: {e}")
            else:
                print(f"In test case '{file_path}', an error occurred: {e}")
            traceback.print_exc()

    if args.verbose:
        print("=" * 102)
    if total_errors_all > 0:
        overall_pct = (total_killed_all / total_errors_all) * 100
    else:
        overall_pct = 0.0
        
    overall_gold_pct = (total_gold_valid_cnt / total_test_cases) * 100 if total_test_cases > 0 else 0.0
    overall_mutant_pct = (total_mutants_valid_cnt / total_errors_all) * 100 if total_errors_all > 0 else 0.0
    overall_base_str = f"{overall_gold_pct:.1f}% / {overall_mutant_pct:.1f}%"
        
    caught_str = f"{total_killed_all}/{total_errors_all}"
    
    if args.verbose:
        print(f"{'OVERALL':<45} | {overall_base_str:<15} | {caught_str:<10} | {overall_pct:>5.1f}% | {total_datasets_all:<10}")
        print("=" * 102)
    else:
        print("\n=== OVERALL SUMMARY ===")
        print(f"Test Cases: {total_test_cases}")
        print(f"Total Mutants: {total_errors_all}")
        print(f"Killed: {total_killed_all}/{total_errors_all} ({overall_pct:.1f}%)")
        print(f"Base Valid: Gold {overall_gold_pct:.1f}%, Mutants {overall_mutant_pct:.1f}%")
        print(f"Datasets Generated: {total_datasets_all}")

if __name__ == "__main__":
    main()
