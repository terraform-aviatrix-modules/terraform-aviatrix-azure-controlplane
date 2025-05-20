import subprocess
import json
import sys

if len(sys.argv) != 3:
    print("Usage: python3 accept_license.py <controller_urn> <copilot_urn>")
    sys.exit(1)

controller_urn = sys.argv[1]
copilot_urn = sys.argv[2]

def accept_terms(urn):
    # Check if terms are already accepted
    process = subprocess.Popen(['az', 'vm', 'image', 'terms', 'show', '--urn', urn], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = process.communicate()

    if process.returncode != 0:
        print(f"Error checking terms for {urn}: {err.decode()}", file=sys.stderr)
        sys.exit(1)

    d = json.loads(out)
    if not d.get('accepted', False):
        print(f"Terms for {urn} not accepted. Accepting now...")
        # Accept the terms if not already accepted
        process = subprocess.Popen(['az', 'vm', 'image', 'terms', 'accept', '--urn', urn], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = process.communicate()

        if process.returncode != 0:
            print(f"Error accepting terms for {urn}: {err.decode()}", file=sys.stderr)
            sys.exit(1)
        print(f"Terms for {urn} accepted.")
    else:
        print(f"Terms for {urn} are already accepted.")

# Accept terms for both the controller and copilot images
accept_terms(controller_urn)
accept_terms(copilot_urn)