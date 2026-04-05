#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
Usage: ./read_write_heap.py pid search_string replace_string
"""

import sys
import os

def print_usage():
    """Prints usage and exits with status 1"""
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def main():
    # 1. Argument Validation
    if len(sys.argv) != 4:
        print_usage()

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Error: PID must be a number.")
        print_usage()

    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    if not search_string:
        print("Error: Search string cannot be empty.")
        sys.exit(1)

    maps_filename = f"/proc/{pid}/maps"
    mem_filename = f"/proc/{pid}/mem"

    # 2. Find the Heap boundaries in /proc/[pid]/maps
    heap_start = None
    heap_end = None

    try:
        with open(maps_filename, 'r') as f:
            for line in f:
                if "[heap]" in line:
                    # Example line: 555e646e0000-555e64701000 rw-p 00000000 00:00 0 [heap]
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    break
    except FileNotFoundError:
        print(f"Error: Process with PID {pid} not found.")
        sys.exit(1)
    except PermissionError:
        print(f"Error: Permission denied reading {maps_filename}.")
        sys.exit(1)

    if heap_start is None:
        print(f"Error: Could not find [heap] for PID {pid}.")
        sys.exit(1)

    print(f"[*] Found heap at: [{hex(heap_start)} - {hex(heap_end)}]")

    # 3. Search and Replace in /proc/[pid]/mem
    try:
        with open(mem_filename, 'rb+') as f:
            # Move pointer to the start of the heap
            f.seek(heap_start)
            heap_content = f.read(heap_end - heap_start)

            # Find the index of the search string (byte-match)
            search_bytes = search_string.encode('ascii')
            try:
                index = heap_content.index(search_bytes)
            except ValueError:
                print(f"Error: String '{search_string}' not found in the heap.")
                sys.exit(1)

            print(f"[*] Found '{search_string}' at offset {hex(index)}")

            # Seek to the exact location in the process memory
            f.seek(heap_start + index)
            
            # Write the replacement
            f.write(replace_string.encode('ascii'))
            print(f"[*] Successfully replaced with '{replace_string}'")

    except PermissionError:
        print("Error: Permission denied. Run with sudo.")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
