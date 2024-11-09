import subprocess
import json

process = subprocess.Popen(['az','vm', 'image', 'terms', 'show', '--urn', 'aviatrix-systems:aviatrix-copilot:avx-cplt-byol-02:4.10.0'], stdout=subprocess.PIPE)
out, err = process.communicate()
d = json.loads(out)
if d['accepted'] == False:
    process = subprocess.Popen(['az','vm', 'image', 'terms', 'accept', '--urn', 'aviatrix-systems:aviatrix-copilot:avx-cplt-byol-02:4.12.0'], stdout=subprocess.PIPE)
