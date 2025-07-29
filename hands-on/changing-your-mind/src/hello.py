#!/usr/bin/env python3

import argparse
from functools import partial
from utils import say_something

def main():
    parser = argparse.ArgumentParser(description='Say something to someone.')
    parser.add_argument('name', type=str, help='The name of the person to address.')

    args = parser.parse_args()

    # Use partial to create a function with the message pre-filled
    say_hello = partial(say_something, msg='Hello')

    # Call the function with the provided name
    result = say_hello(name=args.name)
    
    print(result)

if __name__ == '__main__':
    main()
