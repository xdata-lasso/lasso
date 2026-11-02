"""
Unit test suite verifying retry and cross-checking logic:
1. is_completed_evaluation rules (verifying physical existence of counterexamples for NEQ/NEQ_SCO).
2. load_existing_results deduplication semantics (keeping latest row).
3. filter_predictions_for_evaluation cross-checking queries.json with results CSVs.
"""

import os
import sys
import tempfile
import unittest
import csv

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
EXP_DIR = os.path.join(BASE_DIR, "experiments")
if EXP_DIR not in sys.path:
    sys.path.insert(0, EXP_DIR)

import csv_utils


class TestRetryLogic(unittest.TestCase):

    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.results_dir = self.temp_dir.name

    def tearDown(self):
        self.temp_dir.cleanup()

    def test_completed_equivalence_statuses(self):
        """Equivalence statuses (EQ_EXEC, EXEC_EQ, EQ, EQU) require no counterexample and are completed."""
        for eq_status in ["EQ_EXEC", "EXEC_EQ", "EQ", "EQU"]:
            row = {"EXTEST_STATUS": eq_status, "reproducible_cex": ""}
            self.assertTrue(
                csv_utils.is_completed_evaluation(row, self.results_dir),
                f"Expected {eq_status} to be considered completed"
            )
        # Verify raw_tool_status == EQU (Polygon format) is also recognized as completed
        row_raw = {"raw_tool_status": "EQU", "EXTEST_STATUS": "", "reproducible_cex": ""}
        self.assertTrue(csv_utils.is_completed_evaluation(row_raw, self.results_dir))

    def test_neq_with_valid_counterexample_file(self):
        """NEQ and NEQ_SCO with a valid, non-empty file on disk are considered completed."""
        cex_rel = "reproducible_cex/test/cex_1.sql"
        cex_full = os.path.join(self.results_dir, cex_rel)
        os.makedirs(os.path.dirname(cex_full), exist_ok=True)
        with open(cex_full, "w", encoding="utf-8") as f:
            f.write("SELECT 1;")

        for neq_status in ["NEQ", "NEQ_SCO"]:
            row = {"EXTEST_STATUS": neq_status, "reproducible_cex": cex_rel}
            self.assertTrue(
                csv_utils.is_completed_evaluation(row, self.results_dir),
                f"Expected {neq_status} with valid counterexample file to be considered completed"
            )

    def test_neq_with_missing_counterexample_field(self):
        """NEQ with empty or missing reproducible_cex field is incomplete."""
        row = {"EXTEST_STATUS": "NEQ", "reproducible_cex": ""}
        self.assertFalse(csv_utils.is_completed_evaluation(row, self.results_dir))

    def test_neq_with_nonexistent_counterexample_file(self):
        """NEQ pointing to a non-existent file path is incomplete."""
        row = {"EXTEST_STATUS": "NEQ", "reproducible_cex": "reproducible_cex/test/nonexistent.sql"}
        self.assertFalse(csv_utils.is_completed_evaluation(row, self.results_dir))

    def test_neq_with_empty_counterexample_file(self):
        """NEQ pointing to an empty (0-byte) file is incomplete."""
        cex_rel = "reproducible_cex/test/empty.sql"
        cex_full = os.path.join(self.results_dir, cex_rel)
        os.makedirs(os.path.dirname(cex_full), exist_ok=True)
        open(cex_full, "w").close()

        row = {"EXTEST_STATUS": "NEQ", "reproducible_cex": cex_rel}
        self.assertFalse(csv_utils.is_completed_evaluation(row, self.results_dir))

    def test_neq_with_raw_counterexample_validation(self):
        """If raw_counterexample is present, it must also exist and be non-empty."""
        cex_rel = "reproducible_cex/test/cex.sql"
        cex_full = os.path.join(self.results_dir, cex_rel)
        os.makedirs(os.path.dirname(cex_full), exist_ok=True)
        with open(cex_full, "w", encoding="utf-8") as f:
            f.write("SELECT 1;")

        # Missing raw_counterexample file
        row = {
            "EXTEST_STATUS": "NEQ",
            "reproducible_cex": cex_rel,
            "raw_counterexample": "raw_cex/missing.txt"
        }
        self.assertFalse(csv_utils.is_completed_evaluation(row, self.results_dir))

        # Existing non-empty raw_counterexample file
        raw_rel = "raw_cex/valid.txt"
        raw_full = os.path.join(self.results_dir, raw_rel)
        os.makedirs(os.path.dirname(raw_full), exist_ok=True)
        with open(raw_full, "w", encoding="utf-8") as f:
            f.write("raw diff")

        row["raw_counterexample"] = raw_rel
        self.assertTrue(csv_utils.is_completed_evaluation(row, self.results_dir))

    def test_error_and_timeout_statuses(self):
        """Errors, timeouts, and incomplete statuses are never considered completed."""
        incomplete_statuses = [
            "ERROR_QUERY_EXECUTION",
            "TOOL_ERROR",
            "TIMEOUT",
            "NO_DATASETS",
            "NO_CEX",
            "SKIPPED",
            "UNKNOWN",
            ""
        ]
        for st in incomplete_statuses:
            row = {"EXTEST_STATUS": st, "reproducible_cex": ""}
            self.assertFalse(
                csv_utils.is_completed_evaluation(row, self.results_dir),
                f"Expected status '{st}' to be considered incomplete"
            )

    def test_load_existing_results_deduplication(self):
        """load_existing_results keeps the latest row for any duplicate (instance_id, prediction_id)."""
        csv_path = os.path.join(self.results_dir, "test.csv")
        with open(csv_path, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=["instance_id", "prediction_id", "EXTEST_STATUS"])
            writer.writeheader()
            writer.writerow({"instance_id": "inst_1", "prediction_id": "pred_1", "EXTEST_STATUS": "ERROR_QUERY_EXECUTION"})
            writer.writerow({"instance_id": "inst_1", "prediction_id": "pred_1", "EXTEST_STATUS": "EQ_EXEC"})

        results = csv_utils.load_existing_results(csv_path)
        self.assertEqual(len(results), 1)
        self.assertEqual(results[("inst_1", "pred_1")]["EXTEST_STATUS"], "EQ_EXEC")

    def test_cross_check_filtering_queries_json(self):
        """
        filter_predictions_for_evaluation ensures:
        - Completed queries are skipped.
        - Failed queries are retried.
        - Queries with missing CEX files are retried.
        - Queries from queries.json not present in CSV are evaluated.
        """
        csv_file = os.path.join(self.results_dir, "tool_bird.csv")
        cex_file = os.path.join(self.results_dir, "cex.sql")
        with open(cex_file, "w", encoding="utf-8") as f:
            f.write("SELECT 1;")

        # Existing CSV:
        # q0_p0: NEQ with valid CEX -> completed (skip)
        # q0_p1: NEQ with missing CEX -> retry
        # q1_p0: ERROR_QUERY_EXECUTION -> retry
        with open(csv_file, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=["instance_id", "prediction_id", "EXTEST_STATUS", "reproducible_cex"])
            writer.writeheader()
            writer.writerow({"instance_id": "q0", "prediction_id": "q0_p0", "EXTEST_STATUS": "NEQ", "reproducible_cex": "cex.sql"})
            writer.writerow({"instance_id": "q0", "prediction_id": "q0_p1", "EXTEST_STATUS": "NEQ", "reproducible_cex": "missing.sql"})
            writer.writerow({"instance_id": "q1", "prediction_id": "q1_p0", "EXTEST_STATUS": "ERROR_QUERY_EXECUTION", "reproducible_cex": ""})

        # queries.json has 4 predictions across 3 instances:
        # q0: q0_p0, q0_p1
        # q1: q1_p0
        # q2: q2_p0 (missing from CSV)
        data = [
            {"id": "q0", "source": "bird", "predictions": [{"prediction_id": "q0_p0"}, {"prediction_id": "q0_p1"}]},
            {"id": "q1", "source": "bird", "predictions": [{"prediction_id": "q1_p0"}]},
            {"id": "q2", "source": "bird", "predictions": [{"prediction_id": "q2_p0"}]}
        ]

        filtered, total = csv_utils.filter_predictions_for_evaluation(
            data=data,
            results_dir=self.results_dir,
            csv_file_func=lambda src: csv_file,
            retry=True,
            tool_name="TestTool"
        )

        self.assertEqual(total, 3)
        remaining = [p["prediction_id"] for item in filtered for p in item["predictions"]]
        self.assertEqual(remaining, ["q0_p1", "q1_p0", "q2_p0"])

    def test_polygon_equ_skipped_during_retry(self):
        """Polygon predictions with status 'EQU' must be skipped during --retry."""
        csv_file = os.path.join(self.results_dir, "polygon_bird.csv")
        with open(csv_file, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=["instance_id", "prediction_id", "raw_tool_status", "EXTEST_STATUS", "reproducible_cex"])
            writer.writeheader()
            writer.writerow({"instance_id": "q0", "prediction_id": "q0_p0", "raw_tool_status": "EQU", "EXTEST_STATUS": "EQU", "reproducible_cex": ""})
            writer.writerow({"instance_id": "q0", "prediction_id": "q0_p1", "raw_tool_status": "TIMEOUT", "EXTEST_STATUS": "TIMEOUT", "reproducible_cex": ""})

        data = [
            {"id": "q0", "source": "bird", "predictions": [{"prediction_id": "q0_p0"}, {"prediction_id": "q0_p1"}]}
        ]

        filtered, total = csv_utils.filter_predictions_for_evaluation(
            data=data,
            results_dir=self.results_dir,
            csv_file_func=lambda src: csv_file,
            retry=True,
            tool_name="Polygon"
        )

        self.assertEqual(total, 1)
        remaining = [p["prediction_id"] for item in filtered for p in item["predictions"]]
        self.assertEqual(remaining, ["q0_p1"])


if __name__ == "__main__":
    unittest.main()
