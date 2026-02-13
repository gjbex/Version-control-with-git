#!/usr/bin/env python

import sys
import argparse


def main():
    arg_parser = argparse.ArgumentParser(
            description="A simple hello world script"
    )
    arg_parser.add_argument(
            "name",
            nargs="?",
            default="World",
            help="The name to greet (default: World)"
    )
    args = arg_parser.parse_args()
    print(f"Bye, {args.name}!")


if __name__ == "__main__":
    main()
