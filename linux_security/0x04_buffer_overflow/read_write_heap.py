k#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
Usage: ./read_write_heap.py pid search_string replace_string
"""

import sys

def main():
    # Argument validation
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    # Convert strings to bytes for binary memory manipulation
    search_bytes = search_str.encode('ascii')
    replace_bytes = replace_str.encode('ascii')

    try:
        # 1. Parse /proc/[pid]/maps to find the heap
        heap_start = None
        heap_end = None
        
        with open(f"/proc/{pid}/maps", "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    # Format: 555e646e0000-555e64701000 rw-p ... [heap]
                    addr_range = line.split()[0]
                    start, end = addr_range.split('-')
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break

        if heap_start is None:
            sys.exit(1)

        # 2. Open /proc/[pid]/mem and perform the replacement
        with open(f"/proc/{pid}/mem", "rb+") as mem_file:
            # Seek to the start of the heap
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            # Find the string offset within the heap
            offset = heap_data.find(search_bytes)
            if offset == -1:
                sys.exit(1)

            # Seek to the exact location of the string in the process memory
            mem_file.seek(heap_start + offset)
            
            # Overwrite with the new string
            mem_file.write(replace_bytes)
            
    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    main()
