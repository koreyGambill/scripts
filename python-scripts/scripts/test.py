# Testing argument parsing
#
# Run `python3 test.py -h` to see help info.
# Pass in arguments liek `python3 test.py --noop --testVar "this_is_a_test_string"`
# --noop will default to false, but if it's present it will store true.
# --testVar will default to "default string value"

import argparse

def main():

    # Argument Parser
    parser = argparse.ArgumentParser(
        description='This is a test script')
    parser.add_argument("--noop", action="store_true", help="Turn on NOOP which will output the changes, but not do them.")
    parser.add_argument('--testVar', type=str, default='default string value', help='Just a test variable. Set to any string.')
    args = parser.parse_args()

    print("Here are the arguments you passed in")
    print(args)
    
if __name__ == "__main__":
    main()
