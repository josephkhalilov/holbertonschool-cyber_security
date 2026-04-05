#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
"""

import sys

def main():
    # Argument validation
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2].encode('ascii')
    replace_str = sys.argv[3].encode('ascii')

    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    try:
        # 1. Find heap boundaries
        heap_start = None
        heap_end = None
        with open(maps_path, 'r') as f:
            for line in f:
                if "[heap]" in line:
                    addr_range = line.split()[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    break

        if heap_start is None:
            sys.exit(1)

        # 2. Open memory file and perform the replacement
        with open(mem_path, 'rb+') as f:
            f.seek(heap_start)
            heap_data = f.read(heap_end - heap_start)
            
            # Find the string in the heap data
            offset = heap_data.find(search_str)
            if offset == -1:
                sys.exit(1)

            # Seek to the absolute address in memory and write
            f.seek(heap_start + offset)
            f.write(replace_str)
            
        print("SUCCESS!")

    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    main()
