k#!/usr/bin/python3
"""
Finds and replaces a string in a process's heap.
Usage: ./read_write_heap.py pid search_string replace_string
"""
import sys

def main():
    if len(sys.argv) != 4:
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2].encode('ascii')
    replace_str = sys.argv[3].encode('ascii')

    try:
        # 1. Locate the heap
        with open(f"/proc/{pid}/maps", 'r') as f:
            heap_info = None
            for line in f:
                if "[heap]" in line:
                    heap_info = line.split()[0].split('-')
                    break
            
            if not heap_info:
                sys.exit(1)
            
            addr_start = int(heap_info[0], 16)
            addr_end = int(heap_info[1], 16)

        # 2. Write to memory
        with open(f"/proc/{pid}/mem", 'rb+') as f:
            f.seek(addr_start)
            heap_data = f.read(addr_end - addr_start)
            
            offset = heap_data.find(search_str)
            if offset == -1:
                sys.exit(1)

            # Move to the exact memory address and overwrite
            f.seek(addr_start + offset)
            f.write(replace_str)
            
            # Print success and EXIT IMMEDIATELY
            print("SUCCESS!")
            sys.exit(0)

    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    main()
