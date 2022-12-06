import os
import random
import sys
import subprocess

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
    array = [random.randint(-100, 100) for _ in range(random.randint(1, 10000))]
    correct_array = array.copy()
    for j in range(len(correct_array)):
        if correct_array[j] <= 0:
            correct_array[j] -= 5
        else:
            break
    return (array, correct_array)

def format_input(data: list) -> str:
    return f"{len(data)} {' '.join(map(str, data))}"

def run_test(exe: str, input: str, arguments: list) -> str:
    process = subprocess.Popen([exe] + arguments, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate(input=input.encode())
    return output.decode()


def test_random(exe: str, tests_qnt: int) -> bool:
    for i in range(tests_qnt):
        output =  run_test(exe, "", ["-random", "30000", str(random.randint(1, 10000))])
        generated_string = output.split("\n")[0]
        generated_data =  [int(x) for x in generated_string.split()] 
        result_string = output.split("\n")[1]
        result_data = [int(x) for x in result_string.split()]
        correct_answer = generated_data.copy()
        for j in range(len(correct_answer)):
            if correct_answer[j] <= 0:
                correct_answer[j] -= 5
            else:
                break
        if result_data != correct_answer:
            print("Input: ")
            print(generated_data)
            print("Output: ")
            print(result_data)
            return False
    return True

def tests(exe: str, data: list, test_data: list, file: bool = False) -> bool:
    for data in test_data:
        array, correct_array = data
        input = format_input(array)

        output_array = list()
        if file:
            input_filepath = os.path.join(__location__, "temp/input.txt")
            output_filepath = os.path.join(__location__, "temp/output.txt")

            with open(input_filepath, "w") as f:
                f.write(input)
            output = run_test(exe, "", ["-file", input_filepath, output_filepath])
            with open(output_filepath, "r") as f:
                output = f.read()
                output_array = list(map(int, output.split()))[1:]
        else :
            output = run_test(exe, input, [])
            output_array = output.split("\n")[0].split("Enter n: ")[1]
            output_array = [int(x) for x in output_array.split()]

        if output_array != correct_array:
            print("Input: ")
            print(correct_array)
            print("Output: ")
            print(output_array)
            return False
    return True
        
   
def stress_tests_rand(exe: str) -> float:
    total_microseconds = 0
    for i in range(1010, 1012):
        output = run_test(exe, "", ["-test", str(i)])
        total_microseconds += float(output.split("\n")[0].split("Time elapsed: ")[1].split()[0])
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

    print(f"\nRunning {tests_qnt} tests of random on each executable...")
    for exe in executables:
        if test_random(exe, tests_qnt):
            print(f"{bcolors.OKGREEN}✓ {exe}:\tRandom Tests Passed{bcolors.ENDC}")
        else:
            print(f"{bcolors.FAIL}X {exe}:\t Random Tests Failed{bcolors.ENDC}")
            exit(1)
    print(f"\nRunning {tests_qnt} tests on each executable...")
    for exe in executables:
        if not tests(exe, test_data, test_data):
            print(f"{bcolors.FAIL}X {exe}:\tConsole Tests failed{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}✓ {exe}:\tConsole Tests passed{bcolors.ENDC}")

    for exe in executables:
        if not tests(exe, test_data, test_data, file=True):
            print(f"{bcolors.FAIL}X {exe}:\tFile Tests failed{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}✓ {exe}:\tFile Tests passed{bcolors.ENDC}")

    print(f"\nRunning stress tests on each executable... {bcolors.OKBLUE}")
    for exe in executables:
        print(f"{exe}:\t{stress_tests_rand(exe) / 1000000} seconds")
    print(bcolors.ENDC)
