#
#  pasre.py
#
#  Copyright (c) 2020 ARMRef (https:#github.com/evilpenguin/ARMRef)
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

import argparse
import json

from pathlib import Path
from lxml import etree

def _node_text(node):
    result = ""

    if node.text:
        result = node.text

    for child in node:
        if child.tail is not None:
            result += child.tail

    return result.strip()

def _parse(atPath):
    dictionary = []

    # Paths
    paths = [pth for pth in Path(atPath).iterdir() if pth.suffix == ".xml"]
    
    # Loop
    for path in paths:
        with open(path) as fd:
            instruction = {}
            
            # Root
            root = etree.parse(fd).getroot()

            # Mnemonic
            heading = root.xpath("heading")
            if heading is None or len(heading) == 0: continue
            instruction["mnemonic"] = _node_text(heading[0])

            # Short desc
            brief = root.xpath("desc/brief/para")
            if brief is None or len(brief) == 0: brief = root.xpath("desc/brief")
            if brief and len(brief) > 0:
                instruction["short_desc"] = _node_text(brief[0])

            # Full desc
            authored = root.xpath("desc/authored/para")
            if authored is None or len(authored) == 0: authored = root.xpath("desc/description/para")
            if authored and len(authored) > 0:
                instruction["full_desc"] = _node_text(authored[0])

            # Syntax
            instruction["syntax"] = []
            for asmtemplate in root.iterfind("classes/iclass/encoding/asmtemplate"):
                syntax_text = "".join(asmtemplate.itertext()).strip()
                label = asmtemplate.getparent().attrib["label"].strip()
                instruction["syntax"].append(f"{syntax_text}\t; {label}")

            # Symbols
            instruction["symbols"] = []
            for explanations in root.iterfind("explanations/explanation"):
                symbol = ""
                intro = ""

                for explanation in explanations.getchildren():
                    if "symbol" in explanation.tag:
                        symbol = _node_text(explanation)
                    elif "account" in explanation.tag:
                        intro = _node_text(explanation.xpath("intro/para")[0])

                instruction["symbols"].append(f"{symbol}\n{intro}")

            # Decode
            decode = root.xpath("classes/iclass/ps_section/ps/pstext")
            if decode and len(decode) > 0:
                instruction["decode"] = "".join(decode[0].itertext()).strip()

            # Operation
            execute = root.xpath("ps_section/ps/pstext")
            if execute and len(execute) > 0:
                instruction["operation"] = "".join(execute[0].itertext()).strip()

            # Add instruction
            if len(instruction) > 0:
                dictionary.append(instruction)

    return dictionary

def _main():
    # Args
    argParser = argparse.ArgumentParser(prog="ARMParse")
    argParser.add_argument("--dir", "-d", metavar="DIRECTORY", help="the DIRECTORY to parse.", default=None, required=True)
    argParser.add_argument("--json", "-j", metavar="JSON_FILE", help="the JSON_FILE we are saving to.", default=None, required=False)
    args = argParser.parse_args()

    # Parse
    dictionary = _parse(atPath=args.dir)

    # Output
    if args.json:
        with open(args.json, "w") as json_file:
            json_file.write(json.dumps(dictionary))
    else:
        print(json.dumps(decoded))

if __name__ == "__main__":
    _main()  
