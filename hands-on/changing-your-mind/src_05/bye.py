#!/usr/bin/env python3

import argparse
from functools import partial
from utils import say_something

def main():
    parser = argparse.ArgumentParser(description='Say something to someone.')
    parser.add_argument('name', type=str, help='The name of the person to address.')
    parser.add_argument('--repeat', type=int, default=1, help='Number of times to repeat the message.')

    args = parser.parse_args()

    # Use partial to create a function with the message pre-filled
    say_bye = partial(say_something, msg='Bye')

    # Call the function with the provided name
    result = say_bye(name=args.name)
    
    for _ in range(args.repeat - 1):
        print(result)

if __name__ == '__main__':
    main()
