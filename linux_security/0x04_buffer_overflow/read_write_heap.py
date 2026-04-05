#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
Usage: read_write_heap.py pid search_string replace_string
"""

import sys
import os

def print_usage_and_exit():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def read_write_heap():
    # 1. Validation of Arguments
    if len(sys.argv) != 4:
        print_usage_and_exit()

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not pid.isdigit():
        print_usage_and_exit()

    # 2. Locate the Heap in /proc/[pid]/maps
    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    heap_start = None
    heap_end = None

    try:
        with open(maps_path, 'r') as maps_file:
            for line in maps_file:
                # We are looking specifically for the line ending with [heap]
                if "[heap]" in line:
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    
                    # Verify permissions (must have read 'r' and write 'w')
                    permissions = parts[1]
                    if 'r' not in permissions or 'w' not in permissions:
                        print(f"[*] Heap does not have necessary permissions: {permissions}")
                        sys.exit(1)
                    break
    except FileNotFoundError:
        print(f"Error: Process {pid} not found.")
        sys.exit(1)
    except PermissionError:
        print(f"Error: Permission denied reading {maps_path}.")
        sys.exit(1)

    if heap_start is None:
        print(f"[*] Heap not found for process {pid}")
        sys.exit(1)

    print(f"[*] Found Heap: {hex(heap_start)} - {hex(heap_end)}")

    # 3. Read and Write to /proc/[pid]/mem
    try:
        with open(mem_path, 'rb+') as mem_file:
            # Move pointer to the start of the heap
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            # Find the search string in the byte array
            try:
                index = heap_data.index(bytes(search_str, "ascii"))
            except ValueError:
                print(f"[*] String '{search_str}' not found in heap.")
                sys.exit(1)

            print(f"[*] Found '{search_str}' at {hex(heap_start + index)}")

            # Prepare replacement (handle ASCII)
            # Note: Writing past the original string length can be dangerous; 
            # we write exactly the replacement string provided.
            mem_file.seek(heap_start + index)
            mem_file.write(bytes(replace_str, "ascii"))
            
            print(f"[*] Replaced with '{replace_str}'")

    except PermissionError:
        print(f"Error: Permission denied accessing {mem_path}. Try sudo.")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    read_write_heap()
