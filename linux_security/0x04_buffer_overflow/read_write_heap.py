k#!/usr/bin/python3
import sys

# ... [Your logic to find heap_start, heap_end, and offset] ...

if offset != -1:
    f.seek(heap_start + offset)
    f.write(replace_str)
    print("SUCCESS!")
    sys.exit(0)  # Exit immediately after success
else:
    sys.exit(1)
