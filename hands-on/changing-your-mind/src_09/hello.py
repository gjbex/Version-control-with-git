#!/usr/bin/env python3

import argparse
import messanger_factory

def main():
    parser = argparse.ArgumentParser(description='Say something to someone.')
    parser.add_argument('name', type=str, help='The name of the person to address.')
    parser.add_argument('--repeat', type=int, default=1, help='Number of times to repeat the message.')

    args = parser.parse_args()

    # Use factory to create the messanger
    say_hello = messanger_factory.create_messanger('Hello')

    # Call the function with the provided name
    result = say_hello(name=args.name)
    
    for _ in range(args.repeat - 1):
        print(result)

if __name__ == '__main__':
    main()
