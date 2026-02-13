#!/usr/bin/env python

import sys


def main():
    name = sys.argv[1] if len(sys.argv) > 1 else "World"
    print(f"Hello, {name}!")


if __name__ == "__main__":
    main()
