#!/usr/bin/env python3

import os
import argparse
from pathlib import Path

# File extensions and folders to ignore
IGNORE_DIRS = {
    ".git",
    "node_modules",
    "__pycache__",
    ".next",
    "dist",
    "build",
    "venv",
    ".venv",
    "coverage",
    ".idea",
    ".vscode",
}

IGNORE_EXTENSIONS = {
    ".png",
    ".jpg",
    ".jpeg",
    ".gif",
    ".webp",
    ".ico",
    ".pdf",
    ".zip",
    ".tar",
    ".gz",
    ".mp4",
    ".mp3",
    ".woff",
    ".woff2",
    ".ttf",
    ".otf",
    ".lock",
    ".pyc",
}

MAX_FILE_SIZE_MB = 2  # Skip files larger than this


def is_binary(file_path):
    try:
        with open(file_path, "rb") as f:
            chunk = f.read(1024)
            return b"\0" in chunk
    except Exception:
        return True


def should_skip(path):
    if any(part in IGNORE_DIRS for part in path.parts):
        return True

    if path.suffix.lower() in IGNORE_EXTENSIONS:
        return True

    if path.is_file():
        size_mb = path.stat().st_size / (1024 * 1024)
        if size_mb > MAX_FILE_SIZE_MB:
            return True

        if is_binary(path):
            return True

    return False


def collect_files(root_dir):
    files = []

    for path in root_dir.rglob("*"):
        if path.is_file() and not should_skip(path):
            files.append(path)

    return sorted(files)


def create_bundle(root_dir, output_file):
    files = collect_files(root_dir)

    with open(output_file, "w", encoding="utf-8") as out:
        out.write(f"CODEBASE EXPORT\n")
        out.write(f"ROOT: {root_dir}\n")
        out.write("=" * 80 + "\n\n")

        for file_path in files:
            relative_path = file_path.relative_to(root_dir)

            print(f"Reading: {relative_path}")

            try:
                with open(file_path, "r", encoding="utf-8", errors="replace") as f:
                    content = f.read()

                out.write("=" * 80 + "\n")
                out.write(f"FILE: {relative_path}\n")
                out.write("=" * 80 + "\n\n")
                out.write(content)
                out.write("\n\n")

            except Exception as e:
                out.write("=" * 80 + "\n")
                out.write(f"FILE: {relative_path}\n")
                out.write("=" * 80 + "\n")
                out.write(f"[ERROR READING FILE: {e}]\n\n")

    print(f"\nDone.")
    print(f"Output written to: {output_file}")


def main():
    parser = argparse.ArgumentParser(
        description="Export an entire codebase into a single text file."
    )

    parser.add_argument(
        "directory",
        help="Directory to scan"
    )

    parser.add_argument(
        "-o",
        "--output",
        default="codebase_export.txt",
        help="Output filename"
    )

    args = parser.parse_args()

    root_dir = Path(args.directory).resolve()

    if not root_dir.exists():
        print("Error: Directory does not exist.")
        return

    create_bundle(root_dir, args.output)


if __name__ == "__main__":
    main()