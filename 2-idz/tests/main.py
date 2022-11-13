import os
import random
import string
import sys
import subprocess
import time

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

def generate_random_string(size: int) -> str:
    return ''.join(random.choice(string.ascii_lowercase) for _ in range(size))

def generate_test_data(size: int = 1000) -> tuple:
    substring = generate_random_string(random.randint(1, size // 20))
    input_data = str()
    while (len(input_data) < size):
        if(random.randint(0, 1) == 0):
            input_data += generate_random_string(random.randint(1, size // 20))
        else:
            input_data += substring

    indexes = list()
    for i in range(len(input_data) - len(substring) + 1):
        if input_data[i:i + len(substring)] == substring:
            indexes.append(i)
            
    return ((substring, input_data), indexes)

def format_input(data: list) -> str:
    return f"{len(data)} {' '.join(map(str, data))}"

def run_test(exe: str, input: str, arguments: list) -> str:
    process = subprocess.Popen([exe] + arguments, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output = process.communicate(input=input.encode())[0]
    process.stdin.close()
    return output.decode()


def test_random(exe: str, tests_qnt: int) -> bool:
    for i in range(tests_qnt):
        substr = generate_random_string(random.randint(1, 40))

        output =  run_test(exe, "", [substr, "-random", ])
        generated_data = output.split("\n")[0]
        answer = [int(x) for x in output.split("\n")[1].split()]

        correct_answer = list()
        # indexes of substring of substr
        for i in range(len(generated_data) - len(substr) + 1):
            if generated_data[i:i + len(substr)] == substr:
                correct_answer.append(i)
            

        if answer != correct_answer:
            print("Input: ")
            print(generated_data)
            print("Correct answer: ")
            print(correct_answer)
            print("Output: ")
            print(answer)
            return False
    return True

def tests(exe: str, test_data: list, file: bool = False) -> bool:
    for data in test_data:
        (substring, input_data), correct_answer = data

        output_array = list()
        if file:
            input_filepath = os.path.join(__location__, "temp/input.txt")
            output_filepath = os.path.join(__location__, "temp/output.txt")

            with open(input_filepath, "w") as f:
                f.write(input_data)

            output = run_test(exe, "", [substring, "-file", input_filepath, output_filepath])
            with open(output_filepath, "r") as f:
                output_data = f.read()
                output_array = [int(x) for x in output_data.split()]
        else :
            output = run_test(exe, input_data, [substring])
            output_data = output.split("\n")[0]
            output_array = [int(x) for x in output_data.split()]

        if output_array != correct_answer:
            print("Input:")
            print(input_data)
            print("Correct answer:")
            print(correct_answer)
            print("Output:")
            print(output_array)
            return False
    return True
        
   
def stress_tests_rand(exe: str) -> float:
    for seed in range(1024, 1026):
        total_microseconds = 0
        substr = "AdsDSAfdsfsdfwefds"
        output = run_test(exe, "", [substr, "-test", str(seed)])
        total_microseconds += float(output.split("\n")[1].split("Time elapsed: ")[1].split()[0])
    return total_microseconds

__location__ = os.path.realpath(
    os.path.join(os.getcwd(), os.path.dirname(__file__)))
    
if __name__ == "__main__":
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

    tests_qnt = 300
    test_data = list([generate_test_data() for _ in range(tests_qnt)])

    # print(f"\nRunning {tests_qnt} tests of random on each executable...")
    # for exe in executables:
    #     if test_random(exe, tests_qnt):
    #         print(f"{bcolors.OKGREEN}✓ {exe}:\tRandom Tests Passed{bcolors.ENDC}")
    #     else:
    #         print(f"{bcolors.FAIL}X {exe}:\t Random Tests Failed{bcolors.ENDC}")
    #         exit(1)

    # print(f"\nRunning {tests_qnt} tests on each executable...")
    # for exe in executables:
    #     if not tests(exe, test_data):
    #         print(f"{bcolors.FAIL}X {exe}:\tConsole Tests failed{bcolors.ENDC}")
    #     else:
    #         print(f"{bcolors.OKGREEN}✓ {exe}:\tConsole Tests passed{bcolors.ENDC}")

    for exe in executables:
        if not tests(exe, test_data, file=True):
            print(f"{bcolors.FAIL}X {exe}:\tFile Tests failed{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}✓ {exe}:\tFile Tests passed{bcolors.ENDC}")

    print(f"\nRunning stress tests on each executable... {bcolors.OKBLUE}")
    for exe in executables:
        print(f"{exe}:\t{stress_tests_rand(exe) / 1000000} seconds")
    print(bcolors.ENDC)
