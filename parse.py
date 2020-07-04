from pathlib import Path
from json import dumps

from lxml import etree

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
        for intro in root.iterfind(".//explanation/account/intro/para"):
            intro_text = "".join(intro.itertext())
            register = f"<{intro.getparent().getparent().attrib['encodedin']}>"
            out["symbols"].append(f"{register}\n{intro_text}")

        decode_code = root.find(".//pstext[@rep_section='decode']")
        if decode_code is not None:
            out["decode"] = "".join(decode_code.itertext())

        execute_code = root.find(".//pstext[@rep_section='execute']")
        if execute_code is not None:
            out["operation"] = "".join(execute_code.itertext())

        decoded.append(out)
print(dumps(decoded))