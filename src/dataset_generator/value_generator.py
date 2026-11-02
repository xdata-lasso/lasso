"""
Value Generator Module
======================

Generates typed, unique values and domain-consistent string/numeric attributes using Faker,
context-isolated seed control, and column-specific type dispatches.
"""

import contextvars
import re
import string
from datetime import date, timedelta
from typing import Any, Optional

from faker import Faker

from models import Column

class DataFactory:
    _instance_ctx = contextvars.ContextVar('_data_factory_ctx')

    def __init__(self, seed: int = 42):
        self.fake = Faker()
        self.seed = seed
        self.fake.seed_instance(seed)
        self.pk_counter = 1000
        self.date_counter = 0
        self.fallback_uniqueness_set = set()
        self.exhausted_faker_types = set()

    @classmethod
    def get_instance(cls) -> 'DataFactory':
        try:
            return cls._instance_ctx.get()
        except LookupError:
            instance = cls()
            cls._instance_ctx.set(instance)
            return instance
            
    def get_fake(self):
        return self.fake
        
    def increment_pk(self) -> int:
        self.pk_counter += 1
        return self.pk_counter

    def increment_date(self) -> int:
        self.date_counter += 1
        return self.date_counter
        
    def get_fallback_uniqueness_set(self) -> set:
        return self.fallback_uniqueness_set

    def reset(self, seed: Optional[int] = None):
        if seed is not None:
            self.seed = seed
        self.fake = Faker()
        self.fake.seed_instance(self.seed)
        self.fake.unique.clear()
        self.pk_counter = 1000
        self.date_counter = 0
        self.fallback_uniqueness_set.clear()
        self.exhausted_faker_types.clear()

    def clear_uniqueness(self):
        self.fake.unique.clear()
        self.fallback_uniqueness_set.clear()
        self.exhausted_faker_types.clear()

def generate_unique_string_for_column(column: Column, override_limit: int = None) -> str:
    """
    Generates a fake string value using Faker.
    Raises ValueError if called on a non-string column.
    """
    if not column.is_text:
        raise ValueError(f"Faker can only be used for string data types, got {column.data_type} for column {column.name}")
    
    factory = DataFactory.get_instance()
    fake = factory.get_fake()
    faker_key = column.faker_type or "pystr"
    if faker_key in factory.exhausted_faker_types:
        val = f"val_{factory.increment_pk()}"
    else:
        try:
            if column.faker_type:
                faker_method = getattr(fake.unique, column.faker_type, None)
                if faker_method:
                    val = str(faker_method())
                else:
                    val = fake.unique.pystr(min_chars=5, max_chars=10)
            else:
                val = fake.unique.pystr(min_chars=5, max_chars=10)
        except Exception:
            # If Faker runs out of unique values (UniquenessException), mark exhausted and fallback
            factory.exhausted_faker_types.add(faker_key)
            val = f"val_{factory.increment_pk()}"
        
    dt = column.data_type.lower()
    match = re.search(r'(?:(?:var)?char|character\s+varying)\s*\((\d+)\)', dt)
    limit = int(match.group(1)) if match else None
    if override_limit is not None:
        limit = min(limit, override_limit) if limit is not None else override_limit
        
    if limit is not None and len(val) > limit:
        fallback = str(generate_unique_id_for_column(column))
        if len(fallback) > limit:
            chars = string.ascii_lowercase + string.ascii_uppercase + string.digits
            base = len(chars)
            fallback_set = factory.get_fallback_uniqueness_set()

            max_attempts = min(500, base ** limit)
            for _ in range(max_attempts):
                val_int = factory.increment_pk()
                s_chars = []
                temp = val_int
                for _ in range(limit):
                    s_chars.append(chars[temp % base])
                    temp //= base
                s = "".join(reversed(s_chars))
                if s not in fallback_set:
                    fallback_set.add(s)
                    return s

            # If all possible character combinations are exhausted, return the derived string
            return s
        return fallback
    return val

def generate_unique_id_for_column(column: Column) -> Any:
    """
    Generates a unique value suitable for primary keys.
    Always numerical, but returned as string or int based on data_type.
    """
    val = DataFactory.get_instance().increment_pk()
    if column.is_text:
        return str(val)
    return val

def deterministic_date_from_index(index: int) -> str:
    """
    Return a valid ISO date derived only from a deterministic ordinal index.
    The fixed base is the standard Unix epoch calendar day (1970-01-01), and
    each step advances year, month, and day using prime moduli (29, 11, 23) so
    that distinct generated dates also have distinct year (%Y), month (%m), and
    day (%d) components across multi-row and multi-group datasets.
    """
    step = max(0, index - 1)
    year = 1970 + (step % 29)
    month = 1 + (step % 11)
    day = 1 + (step % 23)
    return date(year, month, day).isoformat()

def generate_unique_value_for_column(column: Column, override_limit: int = None) -> Any:
    if column.is_text:
        return generate_unique_string_for_column(column, override_limit=override_limit)
    if column.is_temporal:
        return deterministic_date_from_index(DataFactory.get_instance().increment_date())
    val = generate_unique_id_for_column(column)
    dt = column.data_type.lower()
    if any(t in dt for t in ("decimal", "float", "real", "double", "numeric")):
        match = re.search(r'(?:numeric|decimal)\s*\((\d+)(?:\s*,\s*(\d+))?\)', dt)
        if match:
            p = int(match.group(1))
            s = int(match.group(2)) if match.group(2) else 0
            max_val = 10**(p-s) - 1
            if max_val > 0:
                val = val % max_val
                if val == 0:
                    val = 1
        return float(val) + 0.5
    return val

def _match_iso_date_like_pattern(pattern: str, is_temporal: bool = False) -> Optional[str]:
    """
    If `pattern` is an ISO-8601 date/datetime wildcard pattern (e.g. 'YYYY-MM-%',
    'YYYY-%', '%-MM-DD'), return a valid ISO date/datetime string satisfying the
    LIKE pattern so temporal columns and SQLite date functions receive well-formed dates.
    """
    m = re.match(r"^(\d{4})-(\d{2})-(?:%|__)$", pattern)
    if m and 1 <= int(m.group(2)) <= 12:
        return f"{m.group(1)}-{m.group(2)}-01"
    m = re.match(r"^(\d{4})-(\d{2})%$", pattern)
    if m and 1 <= int(m.group(2)) <= 12:
        return f"{m.group(1)}-{m.group(2)}-01"
    m = re.match(r"^(\d{4})-(?:%|__-__)$", pattern)
    if m and 1000 <= int(m.group(1)) <= 9999:
        return f"{m.group(1)}-01-01"
    if is_temporal:
        m = re.match(r"^(\d{4})%$", pattern)
        if m and 1000 <= int(m.group(1)) <= 9999:
            return f"{m.group(1)}-01-01"
    m = re.match(r"^%-(\d{2})-(\d{2})$", pattern)
    if m and 1 <= int(m.group(1)) <= 12 and 1 <= int(m.group(2)) <= 28:
        return f"2000-{m.group(1)}-{m.group(2)}"
    m = re.match(r"^%-(\d{2})-%$", pattern)
    if m and 1 <= int(m.group(1)) <= 12:
        return f"2000-{m.group(1)}-01"
    m = re.match(r"^(\d{4}-\d{2}-\d{2}) %$", pattern)
    if m:
        return f"{m.group(1)} 00:00:00"
    return None


def value_matching_like_pattern(column: Column, pattern: str) -> str:
    iso_date_match = _match_iso_date_like_pattern(pattern, is_temporal=bool(column and column.is_temporal))
    if iso_date_match is not None:
        return iso_date_match

    replacement_source = generate_unique_string_for_column(column) if column.is_text else str(generate_unique_id_for_column(column))
    replacement_index = 0
    result = []

    for character in pattern:
        if character == "%":
            continue
        if character == "_":
            result.append(replacement_source[replacement_index % len(replacement_source)])
            replacement_index += 1
        else:
            result.append(character)

    if result:
        return "".join(result)
    return replacement_source

def coerce_literal_for_column(column: Column, value: Any) -> Any:
    if value == "NULL":
        return None
    if column.is_temporal and isinstance(value, str):
        v_lower = value.lower()
        if v_lower.startswith("date(") or v_lower.startswith("datetime(") or v_lower.startswith("strftime("):
            return deterministic_date_from_index(generate_unique_id_for_column(column))
    if isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit():
        if column.is_text:
            return value
        return float(value) if "." in value else int(value)
    return value


def synthesize_string_of_length(
    column: Optional[Column],
    target_len: int,
    override_limit: Optional[int] = None,
) -> Any:
    """
    Synthesize a deterministic value whose SQL LENGTH(...) equals `target_len`.

    For text columns, generates a whitespace-free alphanumeric string of exact
    length `target_len` (clamped to any VARCHAR/CHAR(N) limit) so that
    `LENGTH(val) == LENGTH(TRIM(val)) == LENGTH(REPLACE(val, ' ', '')) == target_len`.
    For numeric columns, returns a positive integer with `target_len` digits.
    """
    length = max(0, int(target_len))
    if override_limit is not None:
        length = min(length, max(0, int(override_limit)))
    if column is not None and column.data_type:
        m = re.search(r"(?:(?:var)?char|character\s+varying|text)\s*\((\d+)\)", column.data_type.lower())
        if m:
            length = min(length, int(m.group(1)))

    if column is not None and column.is_numeric and not column.is_text:
        if length <= 0:
            return 0
        if length == 1:
            return 1
        return 10 ** (length - 1)

    if length == 0:
        return ""

    if column is not None and column.is_text:
        seed = generate_unique_string_for_column(column)
    else:
        seed = f"val{DataFactory.get_instance().increment_pk()}"

    clean_seed = re.sub(r"\s+", "a", str(seed))
    if not clean_seed:
        clean_seed = "a"

    if len(clean_seed) < length:
        repeats = (length // len(clean_seed)) + 1
        return (clean_seed * repeats)[:length]
    return clean_seed[:length]

