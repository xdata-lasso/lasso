import gc
import multiprocessing
import os
import signal
import sys
import time

def reap_memory():
    """Forces garbage collection to reclaim memory between tool calls."""
    gc.collect()

def _crash_handler(signum, frame):
    # Intercept fatal C signals to exit cleanly and prevent macOS CrashReporter popups
    os._exit(128 + signum)

def _worker_entry(conn, func, args, kwargs):
    try:
        os.setpgrp()
    except Exception:
        pass

    for sig in (signal.SIGSEGV, signal.SIGBUS, signal.SIGABRT, signal.SIGILL, signal.SIGFPE):
        try:
            signal.signal(sig, _crash_handler)
        except (ValueError, OSError):
            pass

    try:
        res = func(*args, **kwargs)
        conn.send(('result', res))
    except Exception as e:
        msg = str(e).strip()
        err_msg = f"{type(e).__name__}: {msg}" if msg else f"{type(e).__name__}: {repr(e)}"
        try:
            conn.send(('error', Exception(err_msg)))
        except Exception:
            pass
    finally:
        try:
            conn.close()
        except Exception:
            pass
        os._exit(0)

def run_with_timeout(func, timeout_sec, *args, **kwargs):
    parent_conn, child_conn = multiprocessing.Pipe(duplex=False)
    ctx_name = 'fork' if sys.platform.startswith('linux') else ('spawn' if sys.platform == 'darwin' else None)
    ctx = multiprocessing.get_context(ctx_name) if ctx_name else multiprocessing
    p = ctx.Process(target=_worker_entry, args=(child_conn, func, args, kwargs))
    p.start()
    child_conn.close()
    
    start_time = time.time()
    result_data = None
    has_result = False

    try:
        while time.time() - start_time < timeout_sec:
            remaining = timeout_sec - (time.time() - start_time)
            if parent_conn.poll(min(0.05, max(0.001, remaining))):
                try:
                    result_data = parent_conn.recv()
                    has_result = True
                except EOFError:
                    pass
                break
            if not p.is_alive():
                if parent_conn.poll():
                    try:
                        result_data = parent_conn.recv()
                        has_result = True
                    except EOFError:
                        pass
                break

        p.join(timeout=max(0.1, timeout_sec - (time.time() - start_time)))

        if p.is_alive():
            try:
                os.killpg(p.pid, signal.SIGKILL)
            except Exception:
                pass
            p.kill()
            p.join()
            raise TimeoutError(f"Task timed out after {timeout_sec}s")

        if has_result and result_data is not None:
            status, val = result_data
            if status == 'error':
                raise val
            return val

        exit_code = p.exitcode
        if exit_code is not None and exit_code != 0:
            if exit_code < 0:
                sig_num = -exit_code
            elif exit_code > 128:
                sig_num = exit_code - 128
            else:
                sig_num = None

            if sig_num is not None:
                try:
                    sig_name = signal.Signals(sig_num).name
                except Exception:
                    sig_name = f"Signal {sig_num}"
                raise RuntimeError(f"Worker process crashed with {sig_name} (exit code {exit_code}).")
            else:
                raise RuntimeError(f"Worker process terminated unexpectedly with exit code {exit_code}.")
        else:
            raise RuntimeError("Worker process terminated unexpectedly without returning a result.")
    finally:
        try:
            parent_conn.close()
        except Exception:
            pass
        try:
            p.close()
        except Exception:
            pass
        reap_memory()

