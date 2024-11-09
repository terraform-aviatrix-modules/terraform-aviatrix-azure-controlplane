import subprocess
import json

process = subprocess.Popen(['az','vm', 'image', 'terms', 'show', '--urn', 'aviatrix-systems:aviatrix-controller:aviatrix-controller-g3:20240923.1605.0'], stdout=subprocess.PIPE)
out, err = process.communicate()
d = json.loads(out)
if d['accepted'] == False:
    process = subprocess.Popen(['az','vm', 'image', 'terms', 'accept', '--urn', 'aviatrix-systems:aviatrix-controller:aviatrix-controller-g3:20240415.2003.0'], stdout=subprocess.PIPE)
