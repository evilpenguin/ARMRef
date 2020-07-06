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

def _parse(atPath):
    paths = [pth for pth in Path("ref").iterdir() if pth.suffix == ".xml"]
    decoded = []

    for path in paths:
        with open(path) as fd:
            root = etree.parse(fd).getroot()
            out = {}

            heading = root.find("heading")
            if heading is None: 
                continue
            out["mnemonic"] = heading.text

            brief = root.find("desc/brief/para")
            if brief is not None:
                out["short_desc"] = "".join(brief.itertext())
                full_desc = ["".join(x.itertext()) for x in root.iterfind("desc/authored/para") if x.text is not None]
                out["full_desc"] = "\n\n".join(full_desc)
            else:
                out["short_desc"] = root.find("desc/brief").text
            
            out["syntax"] = []
            for asmtemplate in root.iterfind("classes/iclass/encoding/asmtemplate"):
                syntax_text = "".join(asmtemplate.itertext()).strip()
                label = asmtemplate.getparent().attrib["label"].strip()
                out["syntax"].append(f"{syntax_text}\t; {label} variant")

            out["symbols"] = []
            for intro in root.iterfind(".#explanation/account/intro/para"):
                intro_text = "".join(intro.itertext())
                register = f"<{intro.getparent().getparent().attrib['encodedin']}>"
                out["symbols"].append(f"{register}\n{intro_text}")

            decode_code = root.find(".#pstext[@rep_section='decode']")
            if decode_code is not None:
                out["decode"] = "".join(decode_code.itertext())

            execute_code = root.find(".#pstext[@rep_section='execute']")
            if execute_code is not None:
                out["operation"] = "".join(execute_code.itertext())

            decoded.append(out)

    return decoded

def _main():
    # Args
    argParser = argparse.ArgumentParser(prog="ARMParse")
    argParser.add_argument("--dir", "-d", metavar="DIRECTORY", help="the DIRECTORY to parse.", default=None, required=True)
    argParser.add_argument("--json", "-j", metavar="JSON_FILE", help="the JSON_FILE we are saving to.", default=None, required=False)
    args = argParser.parse_args()

    # Parse
    decoded = _parse(atPath=args.dir)

    # Output
    if args.json:
        with open(args.json, "w") as json_file:
            json_file.write(json.dumps(decoded))
    else:
        print(json.dumps(decoded))

if __name__ == "__main__":
    _main()  
