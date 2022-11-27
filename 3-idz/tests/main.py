import os
import random
import sys
import subprocess

TESTS_QNT = 300
PERCISE_ANSWER = 1.7263308914223216561367735

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
INPUT_FILE_PATH = os.path.join(__location__, "temp/input.txt")
OUTPUT_FILE_PATH = os.path.join(__location__, "temp/output.txt")

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def generate_test_data(size: int = 1000) -> tuple:
    percision = float("0." + random.randint(0, 8) * '0' + '1') # :))))

    upper_bound = PERCISE_ANSWER * (1 + percision)
    lower_bound = PERCISE_ANSWER * (1 - percision)

    return (percision, lower_bound, upper_bound)

def run_test(exe: str, input: str, arguments: list = list()) -> str:
    process = subprocess.Popen([exe] + arguments, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output = process.communicate(input=input.encode())[0]
    process.stdin.close()
    return output.decode()

def test_random(exe: str, tests_qnt: int) -> bool:
    for i in range(tests_qnt):

        output_raw = run_test(exe, "", ["-random", str(random.randint(1, 23423))])
        output_epsilon = float(output_raw.split("\n")[0].split("Epsilon: ")[1])
        output_root = float(output_raw.split("\n")[1])

        if output_root > PERCISE_ANSWER + output_epsilon or output_root < PERCISE_ANSWER - output_epsilon:
            print("Input:")
            print(percision)
            print("Correct answer:")
            print(f"{lower_bound} < x < {upper_bound}")
            print("Output:")
            print(output)
            return False
    return True

def tests(exe: str, test_data: list, file: bool = False) -> bool:
    for data in test_data:
        (percision, lower_bound, upper_bound) = data

        output_raw = str()
        output = int()

        if file:
            with open(INPUT_FILE_PATH, "w") as f:
                f.write(str(percision))

            output = run_test(exe, "", [str(percision), "-file", INPUT_FILE_PATH, OUTPUT_FILE_PATH])
            with open(OUTPUT_FILE_PATH, "r") as f:
                output_raw = f.read()

        else :
            output_raw = run_test(exe, "", [str(percision)])

        output = float(output_raw.split("\n")[0])

        if output > upper_bound or output < lower_bound:
            print("Input:")
            print(percision)
            print("Correct answer:")
            print(f"{lower_bound} < x < {upper_bound}")
            print("Output:")
            print(output)
            return False
    return True
   
def stress_tests_rand(exe: str) -> float:
    for seed in range(1024, 1026):
        total_microseconds = 0
        output = run_test(exe, "", ["-test", str(seed)])
        total_microseconds += float(output.split("Time elapsed: ")[1].split()[0])
    return total_microseconds


def main(): 
    if len(sys.argv) < 2:
        print("Usage: python main.py <path_to_file>")
        exit(1)

    print("""
  _____ _____ ______  _______ ______  _____ _______ ______ _____  
 |_   _|  __ \___  / |__   __|  ____|/ ____|__   __|  ____|  __ \ 
   | | | |  | | / /     | |  | |__  | (___    | |  | |__  | |__) |
   | | | |  | |/ /      | |  |  __|  \___ \   | |  |  __| |  _  / 
  _| |_| |__| / /__     | |  | |____ ____) |  | |  | |____| | \ \ 
 |_____|_____/_____|    |_|  |______|_____/   |_|  |______|_|  \_\
                                                                                                                        
""")

    executables = sys.argv[1:]
    print("Running tests on executables: " + ", ".join(executables))

    test_data = list([generate_test_data() for _ in range(TESTS_QNT)])

    print(f"\nRunning {TESTS_QNT} tests of random on each executable...")
    for exe in executables:
        if test_random(exe, TESTS_QNT):
            print(f"{bcolors.OKGREEN}✓ {exe}:\tRandom Tests Passed{bcolors.ENDC}")
        else:
            print(f"{bcolors.FAIL}X {exe}:\t Random Tests Failed{bcolors.ENDC}")
            exit(1)

    print(f"\nRunning {TESTS_QNT} tests on each executable...")
    for exe in executables:
        if not tests(exe, test_data):
            print(f"{bcolors.FAIL}X {exe}:\tConsole Tests failed{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}✓ {exe}:\tConsole Tests passed{bcolors.ENDC}")

    for exe in executables:
        if not tests(exe, test_data, file=True):
            print(f"{bcolors.FAIL}X {exe}:\tFile Tests failed{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}✓ {exe}:\tFile Tests passed{bcolors.ENDC}")

    print(f"\nRunning stress tests on each executable... {bcolors.OKBLUE}")
    for exe in executables:
        print(f"{exe}:\t{stress_tests_rand(exe) / 1000000} seconds")
    print(bcolors.ENDC)
    
if __name__ == "__main__":
    main()