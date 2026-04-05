#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
Usage: ./read_write_heap.py pid search_string replace_string
"""

import sys
import os

def print_usage_and_exit():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def main():
    # 1. Validation of arguments
    if len(sys.argv) != 4:
        print_usage_and_exit()

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Error: PID must be a number")
        print_usage_and_exit()

    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not search_str:
        print("Error: Search string cannot be empty")
        sys.exit(1)

    # 2. Find the heap range in /proc/[pid]/maps
    maps_filename = f"/proc/{pid}/maps"
    mem_filename = f"/proc/{pid}/mem"
    
    heap_start = None
    heap_end = None

    try:
        with open(maps_filename, 'r') as f:
            for line in f:
                if "[heap]" in line:
                    # Line format: 555e646e0000-555e64701000 rw-p 00000000 00:00 0 [heap]
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    break
    except Exception as e:
        print(f"Error opening/reading maps file: {e}")
        sys.exit(1)

    if heap_start is None:
        print(f"Error: Could not find [heap] for PID {pid}")
        sys.exit(1)

    print(f"[*] Found heap at: [{hex(heap_start)} - {hex(heap_end)}]")

    # 3. Read and Write to /proc/[pid]/mem
    try:
        with open(mem_filename, 'rb+') as f:
            # Move to the start of the heap
            f.seek(heap_start)
            heap_data = f.read(heap_end - heap_start)
            
            # Find the index of the search string
            # We encode strings to bytes because /mem is a binary file
            try:
                index = heap_data.index(search_str.encode('ascii'))
            except ValueError:
                print(f"Error: String '{search_str}' not found in heap.")
                sys.exit(1)

            print(f"[*] Found '{search_str}' at offset {hex(index)}")

            # Seek to the specific location of the string in the process memory
            f.seek(heap_start + index)
            
            # Write the replacement string (and a null terminator if you wish)
            f.write(replace_str.encode('ascii'))
            
            # Optional: if the new string is shorter, you might want to null terminate
            # if len(replace_str) < len(search_str):
            #    f.write(b'\0')

            print(f"[*] Successfully replaced with '{replace_str}'")

    except PermissionError:
        print("Error: Permission denied. Try running with 'sudo'.")
        sys.exit(1)
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
